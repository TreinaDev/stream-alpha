cpf = '12345678910'

d1 = 0
d2 = 0
cpf.each_char.with_index do |number, index|
  d1 += number.to_i * (10 - index) * 10 if index < 9
  d2 += number.to_i * (11 - index) * 10 if index < 10
end

puts cpf.index((d1 % 11).to_s + (d2 % 11).to_s).eql? 9

