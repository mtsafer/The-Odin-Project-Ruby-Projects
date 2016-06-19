# Implement a method #substrings that takes a word as the
# first argument and then an array of valid substrings (your dictionary)
# as the second argument. It should return a hash listing each substring
# (case insensitive) that was found in the original string and how many
# times it was found.

# > dictionary = ["below","down","go","going","horn",
#               "how","howdy","it","i","low","own","part","partner","sit"
#                "below","down","go","going","horn","how","howdy",
#                  "it","i","low","own","part","partner","sit"]
#
#    > substrings("below", dictionary)
#    => {"below"=>1, "low"=>1}

dictionary = ["below","down","go","going","horn",
              "how","howdy","it","i","low","own","part","partner","sit",
              "below","down","go","going","horn","how","howdy",
              "it","i","low","own","part","partner","sit"]

def substrings(string, dictionary)
	found = Hash.new(0)
	for i in 0...string.length
		for j in i...string.length
			if dictionary.include? string[i..j].downcase
				found[string[i..j].downcase] += 1
			end
		end
	end
	found
end

puts substrings("Howdy partner, sit down! How's it going?", dictionary)