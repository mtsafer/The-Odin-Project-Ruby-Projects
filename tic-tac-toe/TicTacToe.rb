class TicTacToe
	
	require_relative './Row'

	def initialize
		@row1 = Row.new()
		@row2 = Row.new()
		@row3 = Row.new()
		@border = "-----"
	end

	def new_game
		@row1 = Row.new()
		@row2 = Row.new()
		@row3 = Row.new()
	end

	def look
		puts "	" + @row1.view
		puts "	" + @border
		puts "	" + @row2.view
		puts "	" + @border
		puts "	" + @row3.view
	end

	def set_spot(nth_row, column, token)
		row = find_row(nth_row)
		if row
			if row.spot_available(column)
			set_helper(row, column, token)
			else
				puts "Spot taken!"
				return false
			end
		else
			puts "invalid row"
		end
	end

	def has_ended?
		ended = false
		ended = check_winner('X') unless ended
		ended = check_winner('O') unless ended
		ended = check_full_board unless ended
		ended
	end

	def spot_available?(x,y)
		unless find_row(x).spot_available(y)
			puts "Spot unavailable!"
			false
		else
			true
		end
	end

	private

		def check_winner(token)
			if check_horizontals(token) == token || 
				 check_verticals(token) == token || 
				 check_diagonals(token) == token
				token
			else
				false 
			end
		end

		def check_full_board
			full = true
			for i in 1..3
				row = find_row(i)
				for j in 1..3
					full = false if row.column(j) == " "
				end
			end
			return "nobody" if full
			full
		end

		def check_verticals(token)
			for i in 1..3
				won = true
				for j in 1..3
					row = find_row(j)
					won = false if row.column(i) != token
				end
				return token if won
			end
			false
		end

		def check_diagonals(token)
			if @row1.column(1) == token
				if @row2.column(2) == token
					if @row3.column(3) == token
						return token
					end
				end
			elsif @row1.column(3) == token
				if @row2.column(2) == token
					if @row3.column(1) == token
						return token
					end
				end
			end
			false 
		end

		def check_horizontals(token)
			for i in 1..3
				row = find_row(i)
				won = true
				for j in 1..3
					won = false if row.column(j) != token
				end
				return token if won
			end
			false
		end

		def set_helper(row, column, token)
			case column
			when 1 then row.column1 = token.upcase
			when 2 then row.column2 = token.upcase
			when 3 then row.column3 = token.upcase
			else puts "invalid column"
			end
		end

		def find_row(n)
			case n
			when 1 then @row1
			when 2 then @row2
			when 3 then @row3
			else false
			end
		end
end

