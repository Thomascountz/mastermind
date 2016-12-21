class Player
  def input
    gets.chomp.downcase.split(' ')
  end

  def input_valid?(input, code_elements)
    input.length == 4 && input.all? { |element| code_elements.include? element }
  end
end
