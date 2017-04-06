require_relative 'fuzzy'

class Tempo < Fuzzy
  def to_s
    "Parametro Tempo:" + super.to_s
  end
end

class Veiculo < Fuzzy
  def to_s
    "Parametro Quantidade Veiculo:" + super.to_s
  end
end