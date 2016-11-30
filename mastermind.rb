class Game
  
  attr_accessor :player
  
  def initialize(option)
    @player = Player.new
    @board = Board.new
    @code = Code.new
    ai_guessor_logic if option == "creator"
    human_guessor_logic if option == "guessor"
  end
  
  def human_guessor_logic
    code = @code.create_code
    current_guess = nil
    puts "Please choose a combination of four of the following colors."
    puts "Notice: repeats are valid"
    puts "#{@code.code_elements}"

    
    until @board.num_of_turns == @board.allowed_turns or @board.game_won?(code, current_guess) do
      
      #record_log(code, current_guess)
      
      puts "\nPlease enter your guess.\n"
      current_guess = @player.input
      if @player.input_valid?(current_guess, @code.code_elements)
        puts "White Pegs: #{@board.white_pegs(code, current_guess)}"
        puts "Black Pegs: #{@board.black_pegs(code, current_guess)}"
        @board.num_of_turns += 1
      else
        puts "Invalid."
      end
    end
    
    if @board.game_won?(code, current_guess)
      puts "Congratulations, you solved it in #{@board.num_of_turns} turns!"
    elsif @board.num_of_turns == @board.allowed_turns
      puts "Sorry, you were unable to guess the code: #{code}."
      
      #record_log(code, current_guess)

    end
  end
  
  def ai_guessor_logic
    
    code = []
    
      puts "Please choose a combination of four of the following colors."
      puts "Notice: repeats are valid"
      puts "#{@code.code_elements}"
    
    until @player.input_valid?(code, @code.code_elements) do
      code = @player.input
      puts "Try again." if @player.input_valid?(code, @code.code_elements) == false
    end

    
    current_guess = %w(red red blue blue)
    
    s = @code.code_elements.repeated_permutation(4).to_a
    
    until @board.num_of_turns == @board.allowed_turns or @board.game_won?(code, current_guess) do
      
      puts "\n"
      puts "CODE: #{code.inspect}"
      puts "GUESS: #{current_guess.inspect}"
      puts "\n"

      score = [@board.white_pegs(code, current_guess), @board.black_pegs(code, current_guess)]
      
      s = s.find_all do |combo| 
        [@board.white_pegs(current_guess, combo), @board.black_pegs(current_guess, combo)] == score
      end
      
      current_guess = s.sample
      
      @board.num_of_turns += 1
      
    end
    
    if @board.game_won?(code, current_guess)
      puts "GUESS: #{current_guess.inspect}"
      puts "The AI has solved it in #{@board.num_of_turns} turns!"
    elsif @board.num_of_turns == @board.allowed_turns
      puts "Congratulations, you beat the AI with: #{code}."
    end    
    
  end
    
  
  class Player
      
    def input
      gets.chomp.downcase.split(" ")
    end
    
    def input_valid?(input, code_elements)
      input.length == 4 && input.all? { |element| code_elements.include? element }
    end
    
  end
  
  class Board
    
    attr_accessor :num_of_turns
    
    def initialize
      @num_of_turns = 0
    end
    
    def white_pegs(code, guess)
    
      pegs = 0
      temp = code.dup
      
      guess.each do |element|
        if temp.include? element
          pegs += 1
          index = temp.index(element)
          temp[index] = nil
          temp.compact
        end
      end
      pegs - black_pegs(code, guess)
    end
  
    def black_pegs(code, guess)
      pegs = 0
      code.length.times do |index|
        if guess[index] == code[index]
          pegs += 1
        end
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
  
  class Code
    
    attr_reader :code_elements
    
    def code_elements
      %w(red blue yellow green purple orange)
    end
    
    def create_code
      code = Array.new
      4.times { code << code_elements.sample }
      code
    end
    
    def get_code
      
    end
    
  end
  
  def record_log(code, current_guess)
    f = File.open("log.txt", "a")
    f.puts Time.now
    f.puts "CURRENT TURN: #{@board.num_of_turns}"
    f.puts "CODE: #{code.inspect}"
    f.puts "GUESS: #{current_guess.inspect}"
    f.puts "\n\n"
    f.close
  end
  
end

puts "Would you like to be the code GUESSOR or CREATOR"

option = gets.chomp.downcase

puts "You have chosen #{option.capitalize}"
puts "\n"
Game.new(option)