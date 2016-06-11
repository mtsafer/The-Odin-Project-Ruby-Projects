class Row
	def initialize
		@row = ["-", " ", "|", " ", "-", " ", "|", " ", "-"]
	end

		def column1=(token)
			@row[0] = token
		end

		def column2=(token)
			@row[4] = token
		end

		def column3=(token)
			@row[8] = token
		end

		def spot_available(n)
			column(n) == "-" ? true : false
		end

		def view
			@row.join
		end

		def column(x)
			@row[(x-1)*4]
		end
end