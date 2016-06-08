#Implement a method #stock_picker that takes in an array of stock prices,
#one for each hypothetical day. It should return a pair of days
#representing the best day to buy and the best day to sell.
#Days start at 0.

#    > stock_picker([17,3,6,9,15,8,6,1,10])
#    => [1,4]  # for a profit of $15 - $3 == $12

# START PSEUDO CODE
	# => For each day, find the best day to sell later,
		#  and record the profit
	# => Compare all days (each day is already optimized)
# END PESUDO CODE

# Returns a hash where each key is a day to buy
# and a value is a day to sell

#The list of days where each index is a day
day_list = [17,3,6,9,15,8,6,1,10]

#Returns a hash where each key is a day
#and values indicate the best day to sell for that day
def optimize_days(days)
	optimized = {}
	days.each do |day|
		profit = 0
		for i in (days.index(day)...days.length)
			if days[i]-day > profit
				profit = days[i]-day
				best_day_to_sell = i
			end
		end
		best_day_to_sell = days.index day if best_day_to_sell.nil?
		optimized[days.index day] = best_day_to_sell
	end
	optimized
end

#Returns a pair of values in an array
#where the first value is the best day to buy
#and the second value is the best day to sell
def pick_best_day(optimized, days)
	buy_day = 0
	sell_day = 0
	profit = 0
	days.each do |day|
		daily_profit = days[optimized[days.index day]] - day
		if daily_profit > profit
			profit = daily_profit
			buy_day = days.index day
			sell_day = optimized[days.index day]
		end
	end
	[buy_day, sell_day]
end

puts pick_best_day(optimize_days(day_list), day_list)