class Row
	def initialize
		@row = [" ", "|", " ", "|", " "]
	end

		def column1=(token)
			@row[0] = token if token.upcase == 'X' || token.upcase == 'O'
		end

		def column2=(token)
			@row[2] = token if token.upcase == 'X' || token.upcase == 'O'
		end

		def column3=(token)
			@row[4] = token if token.upcase == 'X' || token.upcase == 'O'
		end

		def spot_available(n)
			column(n) == " " ? true : false
		end

		def view
			@row.join
		end

		def column(x)
			@row[(x-1)*2]
		end
end