class Board
  attr_accessor :num_of_turns

  def initialize
    @num_of_turns = 0
  end

  def white_pegs(code, guess)
    pegs = 0
    temp = code.dup

    guess.each do |element|
      next unless temp.include? element
      pegs += 1
      index = temp.index(element)
      temp[index] = nil
      temp.compact
    end
    pegs - black_pegs(code, guess)
  end

  def black_pegs(code, guess)
    pegs = 0
    code.length.times do |index|
      pegs += 1 if guess[index] == code[index]
    end
    pegs
  end

  def game_won?(code, guess)
    code == guess
  end

  def allowed_turns
    12
  end
end
