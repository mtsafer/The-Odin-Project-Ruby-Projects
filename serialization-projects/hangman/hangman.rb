require_relative './dictionary'

class Hangman

	def initialize(guesses = 5, min = 5, max = 12)
		@dictionary = Dictionary.new
		@secret = @dictionary.find_random_word(min, max).downcase.split ""
		@secret_save = @secret.join
		@guesses = guesses
		@guessed_letters = []
		@bad_guesses = []
		@turns = 0
		@bad_guess_count = 0 # for the animation
		@fill_in_word = ("_ "*@secret.length).strip
		@drawing = ["    -----",
								"       ||",
								"       ||",
								"       ||",
								"       ||",
								" ______||______",
								"|______||______|\n\n"]
		@drawing_animation = ["    |  ||",
													"   0   ||",
													"   T   ||",
												  "   ^   ||"]
	end

	#returns the secret
	def peek
		@secret_save
	end

	#returns the drawing
	def drawing
		@drawing
	end

	#prints the 'game board' to the console
	def look
		lines = []
		lines << "#{@fill_in_word}"
		lines << ""
		lines << "incorrect letters: #{@bad_guesses.join(", ")}"
		lines << ""
		lines << "turn: #{@turns}"
		lines << ""
		lines << "bad guesses left: #{@guesses}"
	end

	#Prompts a user for a guess
	#uses the guess to move game forward
	def guess_letter
		print "Your guess: "
		guess = gets.chomp.downcase
		return guess if guess == "save"
		if (guess.between?('a','z') && !(@guessed_letters.include? guess)\
			&& guess.length == 1)
			process_guess(guess)
			@guessed_letters << guess
			@turns += 1
		else
			if guess.between?('a','z')
				puts "\nYour guess must be ONE letter" unless guess.length == 1
				puts "\nYou've already guessed that!" if @guessed_letters.include? guess
			else
				puts "\nYour guess must be a letter!" unless guess.between?('a','z')
			end
			puts "Try again!\n\n"
			guess = guess_letter
		end
		guess
	end

	#returns true if the game has ended, false otherwise
	def ended?
		ended = false
		ended = true if(!(@fill_in_word.include? "_") || @guesses <= 0)
		ended
	end

	#returns true if the player has won, false otherwise
	def won?
		won = false
		won = true if (ended? && @guesses > 0)
		won
	end

	private

		#Uses the guess to affect the rest of the game
		def process_guess(guess)
			unless @secret.include? guess
				puts "Bad guess..."
				@bad_guesses << guess
				@guesses -= 1
				@drawing[@bad_guess_count+1] = @drawing_animation[@bad_guess_count]
				@bad_guess_count += 1
			end

			while @secret.include? guess
				@fill_in_word[@secret.index(guess) * 2] = guess
				@secret[@secret.index guess] = " "
			end
		end

end