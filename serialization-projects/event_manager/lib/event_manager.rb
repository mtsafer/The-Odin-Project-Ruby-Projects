require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

#cleans up the zipcode
def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0,5]
end

def legislators_by_zipcode(zipcode)
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

	legislator_names = legislators.collect do |legislator|
		"#{legislator.first_name} #{legislator.last_name}"
	end

	legislator_names.join(", ")
end

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv",
					 headers: true, header_converters: :symbol

contents.each do |row|
	name = row[:first_name]

	zipcode = clean_zipcode(row[:zipcode])

	legislator = legislators_by_zipcode(zipcode)

	puts "name: #{name}, \n    zip: #{zipcode} \
	\n    legislators: #{legislator}\n\n"
end