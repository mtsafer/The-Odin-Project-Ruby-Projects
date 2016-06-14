require_relative './hangman'
require 'yaml'
private
	
	#loads a saved game
	def load_game
		print "Load game (y/n): "
		load = gets.chomp.downcase[0]
		return false if load == 'n'
		return loader if load == 'y'
		load_game if (load != 'n' || load != 'y')
	end

	#Prompts the user for a file to load
	def loader_helper
		if !(Dir.exists? "saves") || Dir["saves/*"].length == 0
			puts "There are no save files...Starting game."
			return false
		end
		saves = Dir.entries("saves")
		saves.delete(".")
		saves.delete("..")
		puts "The save files are: #{saves.join(", ")}"
		print "Type the save name: "
		save = gets.chomp
		unless saves.include? save
			puts "That file doesn't exist. Try again.\n\n"
			save = loader_helper 
		end
		save
	end

	#returns the saved object, or false if there are no saves
	def loader
		save = loader_helper
		if save
			File.open("saves/#{save}", 'r'){ |f|
				return YAML.load(f)
			} 
		end
		false
	end

	#saves a game to ./saves
	def save(game)
		print "Name the save: "
		save_name = gets.chomp.downcase
		Dir.mkdir "saves" unless Dir.exists? "saves"
		file_path = File.join("saves", "#{save_name}")
		File.open(file_path, "w") { |f|
			f.write(YAML.dump(game))
		}
		puts "The game has been saved!"
	end
public

load = load_game
load ? game = load : game = Hangman.new
puts "Type save at any point to save the game"
game.dictionary.close_dictionary
until game.ended?
	game.look.each_with_index do |line, index| #this has to do with the animation
		until line.length >= 30
			line += " "
		end
		line += game.drawing[index]
		puts line
	end
	guess = game.guess_letter
	save(game) if guess == "save"
end
game.look
puts "\n\n#{game.peek}\n\n"

if game.won?
	puts "You won!"
else
	puts "You lose..."
end