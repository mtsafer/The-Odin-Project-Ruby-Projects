#Provides useful methods for handling the dictionary
class Dictionary

	def initialize
		@dictionary = File.readlines "dictionary.txt"
		@dictionary.each { |word| word.chomp! }
	end

	#returns a word that is between the specified min and max
	def find_random_word(min = 1, max = 24)
		sub_dictionary = []
		@dictionary.each do |word|
			sub_dictionary << word if word.length.between?(min, max)
		end
		remove_instance_variable(:@dictionary)
		sub_dictionary[rand(sub_dictionary.length)]
	end
end