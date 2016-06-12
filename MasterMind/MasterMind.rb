require_relative './Row'
require_relative './FeedBack'
require 'colorize'

# Available colors: Red Green Yellow Blue Magenta Cyan

class MasterMind
	def initialize
		@secret = hashify(colorize(generate_secret))
		@turn = 0
		@rows = []
		@feed_backs = []
		for i in 1..12
			@rows << Row.new
			@feed_backs << FeedBack.new
		end
		@border = "--------------------------------"
	end

	def look
		puts ""
		puts "(Feedback)--->     (Guess)"
		puts @border
		puts "#{@feed_backs[0].view} ---> #{@rows[0].view}"
		puts @border
		for i in 1...@turn
			puts "#{@feed_backs[i].view} ---> #{@rows[i].view}"
			puts @border
		end
		puts ""
		puts "#{12 - @turn} turns left"
		puts ""
	end

	def peek
		@secret.each{ |x| print x[:guess] }
		puts ""
	end

	def has_ended
		ended = false
		ended = true if @turn >= 12
		ended = check_feedback unless ended
		peek if ended
		puts "" if ended
		puts "You won!" if ended and @turn < 12
		puts "You lose!" if @turn >= 12
		ended
	end

	def check_feedback
		x = "X".red
		@feed_backs[@turn-1].view == "|#{x}|#{x}|#{x}|#{x}|"
	end

	def take_turn(guesses)
		guesses = colorize(guesses)
		row = @rows[@turn]
		row.column1 = guesses[0]
		row.column2 = guesses[1]
		row.column3 = guesses[2]
		row.column4 = guesses[3]
		@feed_backs[@turn] = set_feedback(guesses)
		@turn += 1
	end

	private

		def hashify(guesses)
			guess_array_hash = []
			guesses.each do |guess|
				guess_array_hash << {guess: guess, looked: false}
			end 
			guess_array_hash
		end

		def generate_secret
			colors = ["r","g","b","y","c","m"]
			secret = []
			4.times{ secret << colors[rand(colors.length)] }
			secret
		end

		def set_feedback(guesses)
			feed_back = @feed_backs[@turn]
			feed_back_helper = []
			guesses.each_with_index do |guess, index|
				if guess == @secret[index][:guess]
					feed_back_helper << "X".red
					@secret[index][:looked] = true
					guesses[index] = " "
				end
			end
			guesses.each_with_index do |guess, index|
				@secret.each do |x|
					unless x[:looked]
						if x[:guess] == guess
							feed_back_helper << "X".white
							x[:looked] = true
							guess = " "
							guesses[index] = " "
						end
					end
				end
			end
			@secret.each{ |x| x[:looked] = false }
			feed_back_helper << ["-","-","-","-"]
			feed_back = assign_feedback(feed_back, feed_back_helper.flatten)
		end

		def assign_feedback(feed_back, feed_back_helper)
			feed_back.column1 = (feed_back_helper[0])
			feed_back.column2 = (feed_back_helper[1])
			feed_back.column3 = (feed_back_helper[2])
			feed_back.column4 = (feed_back_helper[3])
			feed_back
		end

		def colorize(guesses)
			for i in 0..3
				case guesses[i]
				when 'r' then guesses[i] = "X".red
				when 'g' then guesses[i] = "X".green
				when 'b' then guesses[i] = "X".blue
				when 'y' then guesses[i] = "X".yellow
				when 'm' then guesses[i] = "X".magenta
				when 'c' then guesses[i] = "X".cyan
				else
					puts "The guesses are corrupt"
				end
			end
			guesses
		end
end