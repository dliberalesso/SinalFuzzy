class Fuzzy
  attr_accessor :pertinenciaBaixa, :pertinenciaMedia, :pertinenciaAlta

  def initialize(valor)
    self.pertinenciaBaixa = determina_pertinencia_baixa(valor)
    self.pertinenciaMedia = determina_pertinencia_media(valor)
    self.pertinenciaAlta = determina_pertinencia_alta(valor)
  end

  def determina_pertinencia_baixa(valor)
    pertinencia = (5 - valor)/4.0
    return 1 if pertinencia > 1
    return 0 if pertinencia < 0
    pertinencia
  end

  def determina_pertinencia_media(valor)
    pertinencia = valor/4.0
    return 0 if pertinencia < 0
    return pertinencia if pertinencia <= 1

    pertinencia = (10 - valor)/4.0
    return 0 if pertinencia < 0
    return 1 if pertinencia > 1
    pertinencia
  end

  def determina_pertinencia_alta(valor)
    pertinencia = (valor - 5)/4.0
    return 1 if pertinencia > 1
    return 0 if pertinencia < 0
    pertinencia
  end

  def to_s
    "\nPertinencia Baixa = #{self.pertinenciaBaixa}\nPertinencia Media = #{self.pertinenciaMedia}\nPertinencia Alta = #{self.pertinenciaAlta}\n"
  end
end