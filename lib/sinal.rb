require_relative 'fuzzy'

class Sinal
  attr_accessor :tempo, :veiculos, :prioridadeAberturaBaixa, :prioridadeAberturaMedia, :prioridadeAberturaAlta

  def initialize(tmp, veic)
    self.tempo = Fuzzy.new(tmp)
    self.veiculos = Fuzzy.new(veic)
    self.prioridadeAberturaBaixa = regra_abertura_baixa
    self.prioridadeAberturaMedia = regra_abertura_media
    self.prioridadeAberturaAlta = regra_abertura_alta
  end

  def min(a, b)
    a < b ? a : b
  end

  def max(a, b)
    a > b ? a : b
  end

  # rever lógica
  # {T(B) ou [V(B) e T(M)]} = PrioridadeAbertaBaixa
  def regra_abertura_baixa
    max(tempo.pertinenciaBaixa, min(veiculos.pertinenciaBaixa, tempo.pertinenciaMedia))
  end

  # {[(V(B) ou V(M)) e T(A)] ou [V(M) e T(M)]} = PrioridadeAberturaMedia
  def regra_abertura_media
    p1 = min(max(veiculos.pertinenciaBaixa, veiculos.pertinenciaMedia), tempo.pertinenciaAlta)
    p2 = min(veiculos.pertinenciaMedia, tempo.pertinenciaMedia)
    max(p1, p2)
  end

  # {V(A) e [T(M) ou T(A)]} = PrioridadeAberturaAlta
  def regra_abertura_alta
    min(veiculos.pertinenciaAlta, max(tempo.pertinenciaMedia, tempo.pertinenciaAlta))
  end

  def defuzzy
    baixa = 100.0 # (10+20+30+40) faixa determinada para prioridade baixa
    media = 180.0 # (50+60+70) faixa determinada para prioridade media
    alta = 270.0  # (80+90+100) faixa determinada para prioridade alta

    ((baixa * prioridadeAberturaBaixa) + (media * prioridadeAberturaMedia) + (alta * prioridadeAberturaAlta)) /
        ((4.0 * prioridadeAberturaBaixa) + (3.0 * prioridadeAberturaMedia) + (3.0 * prioridadeAberturaAlta))
  end

  def to_s
    "Prioridade de Abertura Sinaleira\n" +
        "Baixa = #{self.prioridadeAberturaBaixa}\n" +
        "Media = #{self.prioridadeAberturaMedia}\n" +
        "Alta = #{self.prioridadeAberturaAlta}\n" +
        "Defuzzy = #{defuzzy}\n"
  end
end