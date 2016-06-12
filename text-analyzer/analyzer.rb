lines = File.readlines("text.txt")
line_count = lines.size
text = lines.join
total_characters = text.length
total_characters_no_whitespace = text.split(" ").join.length
total_words = text.split(" ").length
total_sentences = text.split(/\.|\?|!/).length
paragraph_count = text.split("\n\n").length
stopwords = %w{the a by on for of are with just but and to the my I has some in}

puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_no_whitespace} characters with whitespace"
puts "#{total_words} words"
puts "#{total_sentences} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{total_words/total_sentences} words/sentence (average)"
puts "#{total_sentences/paragraph_count} sentences/paragraph (average)"