require_relative 'sinal'

sinaleiras = []

sinaleiras.push(Sinal.new(5, 2).defuzzy)
sinaleiras.push(Sinal.new(6, 1).defuzzy)
sinaleiras.push(Sinal.new(2, 8).defuzzy)
sinaleiras.push(Sinal.new(5, 5).defuzzy)

max = sinaleiras.max
indice = sinaleiras.find_index(max)

puts("Abre sinal #{indice + 1}.")