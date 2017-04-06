class Fuzzy
  attr_accessor :pertinenciaBaixa, :pertinenciaMedia, :pertinenciaAlta

  def initialize(valor)
    self.pertinenciaBaixa = determinaPertinenciaBaixa(valor)
    self.pertinenciaMedia = determinaPertinenciaMedia(valor)
    self.pertinenciaAlta = determinaPertinenciaAlta(valor)
  end

  def determinaPertinenciaBaixa(valor)
    pertinencia = (0 - valor)/4.0
    if pertinencia > 1 then return 1 end
    if pertinencia < 0 then return 0 end
    pertinencia
  end

  def determinaPertinenciaMedia(valor)
    pertinencia = valor/4.0
    if pertinencia < 0 then return 0 end
    if pertinencia <= 1 then return pertinencia end

    pertinencia = (10 - valor)/4.0
    if pertinencia < 0 then return 0 end
    if pertinencia > 1 then return 1 end
    pertinencia
  end

  def determinaPertinenciaAlta(valor)
    pertinencia = (valor - 5)/4.0
    if pertinencia > 1 then return 1 end
    if pertinencia < 0 then return 0 end
    pertinencia
  end

  def to_s
    "\nPertinencia Baixa = #{self.pertinenciaBaixa}\nPertinencia Media = #{self.pertinenciaMedia}\nPertinencia Alta = #{self.pertinenciaAlta}\n"
  end
end