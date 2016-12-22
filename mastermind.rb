require './lib/game.rb'
puts "Welcome to mastermind."
puts "The object of the game is to guess the combination of four colors."
puts "You will recieve three types of feedback:"
puts "----A white peg means that you've guessed the correct color."
puts "----A black peg means that you've guessed the correct color and position."
puts "----No peg means that you've guessed the incorrect color and position."
puts "Have fun!"

game = Game.new
game.play