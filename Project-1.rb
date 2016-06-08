# Implement a caesar cipher that takes in a string
# and the shift factor and then outputs the modified string

# PSEUDO CODE
# 	convert string to ascii
# 	determine if a char is upper or lowercase (different ranges)
# 	shift ascii characters
# 	if an ascii character is outside its range, wrap to other end
# 	convert back to char
# END PESUDO CODE

# 65-90 = A-Z
# 97-122 = a-z

##############################################################

# returns an array of the ascii values for given string
def to_ascii(string)
	string.bytes
end

#returns true if the given ascii value is a letter
def ascii_letter?(value)
	value.between?('A'.ord, 'Z'.ord) || value.between?('a'.ord, 'z'.ord)
end

#returns the value wrapped within the given range
# => example: if the range were 1..7 and the value were 8
# => return 1
def ascii_wrap(value, range)
	unless range.include? value
		value = range.min if value > range.max
		value = range.max if value < range.min
	end
	value
end

# shift an ascii value by a given magnitude
def shift(value, magnitude)
	if value.between?("a".ord, "z".ord)
		range = ('a'.ord..'z'.ord)
	else
		range = ('A'.ord..'Z'.ord)
	end
	magnitude.abs.times do
		value += magnitude.abs/magnitude
		value = ascii_wrap(value, range) unless range.include? value
	end
	value.chr
end

# returns the encrypted string
# returns false if there are non letter characters in the string
def encrypt(string, magnitude)
	ascii_characters = to_ascii(string)
	ascii_characters.map! do |char|
		if ascii_letter?(char)
			shift(char, magnitude)
		else
			char.chr
		end
	end
	ascii_characters.join
end

def main
	print "String please: "
	string = gets.chomp
	print "Shift by(integer only): "
	shift_by = gets.chomp.to_i
	if shift_by.is_a? Integer
		print "Your new string is: "
		puts encrypt(string, shift_by)
	else
		puts "That's not an integer..."
	end
end

main