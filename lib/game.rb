require_relative 'board'
require_relative 'code'

class Game
  attr_accessor :player

  def initialize
    @board = Board.new
    @code = Code.new
  end

  def play
    code = @code.code
    current_guess = nil
    puts 'Please choose a combination of four of the following colors.'
    puts 'Notice: repeats are valid'
    puts @code.code_elements.to_s

    until (@board.num_of_turns == @board.allowed_turns) || @board.game_won?(code, current_guess)

      puts "\nPlease enter your guess.\n"
      current_guess = input
      if input_valid?(current_guess)
        puts "White Pegs: #{@board.white_pegs(code, current_guess)}"
        puts "Black Pegs: #{@board.black_pegs(code, current_guess)}"
        @board.num_of_turns += 1
      else
        puts 'Invalid.'
      end
    end

    if @board.game_won?(code, current_guess)
      puts "Congratulations, you solved it in #{@board.num_of_turns} turns!"
    elsif @board.num_of_turns == @board.allowed_turns
      puts "Sorry, you were unable to guess the code: #{code}."

    end
  end
  
  def input
    gets.chomp.downcase.split(' ')
  end

  def input_valid?(input)
    input.length == 4 && input.all? { |element| @code.code_elements.include? element }
  end
  
end
