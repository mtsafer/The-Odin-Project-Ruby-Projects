require_relative './hangman'

game = Hangman.new

until game.ended?
	game.look
	game.guess_letter
end
game.look
puts "\n\n#{game.peek}\n\n"

if game.won?
	puts "You won!"
else
	puts "You lose..."
end