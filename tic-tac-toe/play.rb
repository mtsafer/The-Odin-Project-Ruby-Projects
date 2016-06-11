require_relative './TicTacToe'

def start_game
	game = TicTacToe.new
	input = ""
	puts "follow prompts to play."
	until input == 'exit'
		puts ""
		game.look
		puts ""
		start_game if check_game_state(game)
		take_turn('1', 'X', game)
		puts ""
		game.look
		puts ""
		start_game if check_game_state(game)
		take_turn('2', 'O', game)
	end
end

private

	def check_game_state(game)
		winner = game.has_ended?
		puts "The winner was #{winner}!! Starting new game.... \n\n" if winner
		return true if winner
		return false unless winner
	end 

	def take_turn(player, token, game)
		input_row = collect("player #{player} (#{token})", 'row (1,2,3)')
		input_col = collect("player #{player} (#{token})", 'column (1,2,3)')
		available = game.spot_available?(input_row, input_col)
		available ? game.set_spot(input_row, input_col, token) :
								take_turn(player, token, game)
	end

	def collect(player, type)
		print "#{player}, enter #{type}: "
		input = gets.chomp
		if [1,2,3].include? input.to_i
			input.to_i
		else
			input = collect(player, type)
		end
	end

start_game