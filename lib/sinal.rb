require_relative 'parametro'

class Sinal
  attr_accessor :tempo, :veiculos, :prioridadeAberturaBaixa, :prioridadeAberturaMedia, :prioridadeAberturaAlta

  def initialize(tmp, veic)
    self.tempo = Tempo.new(tmp)
    self.veiculos = Veiculo.new(veic)
    self.prioridadeAberturaBaixa = regraAberturaBaixa()
    self.prioridadeAberturaMedia = regraAberturaMedia()
    self.prioridadeAberturaAlta = regraAberturaAlta()
  end

  # {T(B) ou [V(B) e T(M)]} = PrioridadeAbertaBaixa
  def regraAberturaBaixa
    vpb = veiculos.pertinenciaBaixa
    tpm = tempo.pertinenciaMedia
    tpb = tempo.pertinenciaBaixa

    prioridade = vpb <= tpm ? vpb : tpm
    tpb > prioridade ? tpb : prioridade
  end

  # {[(V(B) ou V(M)) e T(A)] ou [V(M) e T(M)]} = PrioridadeAberturaMedia
  def regraAberturaMedia
    vpb = veiculos.pertinenciaBaixa
    vpm = veiculos.pertinenciaMedia
    tpa = veiculos.pertinenciaAlta
    tpm = veiculos.pertinenciaMedia

    p1 = vpb >= vpm ? vpb : vpm
    p1 = tpa if tpa < p1
    p2 = vpm <= tpm ? vpm : tpm
    p1 < p2 ? p2 : p1
  end

  # {V(A) e [T(M) ou T(A)]} = PrioridadeAberturaAlta
  def regraAberturaAlta
    tpm = tempo.pertinenciaMedia
    tpa = tempo.pertinenciaAlta
    vpa = veiculos.pertinenciaAlta

    prioridade = tpm >= tpa ? tpm : tpa
    vpa < prioridade ? vpa : prioridade
  end

  def defuzzy
    baixa = 100.0 # (10+20+30+40) faixa determinada para prioridade baixa
    media = 180.0 # (50+60+70) faixa determinada para prioridade media
    alta = 270.0  # (80+90+100) faixa determinada para prioridade alta

    ((baixa*self.prioridadeAberturaBaixa)+(media*self.prioridadeAberturaMedia)+(alta*self.prioridadeAberturaAlta))/((4.0*self.prioridadeAberturaBaixa)+(3.0*self.prioridadeAberturaMedia)+(3.0*self.prioridadeAberturaAlta))
  end

  def to_s
    "Prioridade de Abertura Sinaleira\nBaixa = #{self.prioridadeAberturaBaixa}\nMedia = #{self.prioridadeAberturaMedia}\nAlta = #{self.prioridadeAberturaAlta}\nDefuzzy = #{defuzzy()}\n"
  end
end