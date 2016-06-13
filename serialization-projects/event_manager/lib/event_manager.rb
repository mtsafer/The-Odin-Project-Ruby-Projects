require 'csv'

#cleans up the zipcode
def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0,5]
end

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv",
					 headers: true, header_converters: :symbol

contents.each do |row|
	name = row[:first_name]

	zipcode = clean_zipcode(row[:zipcode])

	puts "name: #{name}, \n   zip: #{zipcode}\n\n"
end