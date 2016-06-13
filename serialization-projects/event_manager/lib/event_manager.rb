require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

#cleans up the zipcode
def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0,5]
end

#cleans up the phone numbers or returns nil for a bad entry
def clean_phone_numbers(phone)
	return phone if phone.length == 10
	return phone[1,phone.length] if phone.length == 11 && phone[0] == "1"
	nil
end

#returns an array of the legislators from the given zipcode
def legislators_by_zipcode(zipcode)
	Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

#saves custom thank you letters to "output"
def save_thank_you_letters(id, form_letter)
	Dir.mkdir "output" unless Dir.exists? "output"

	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv",
					 headers: true, header_converters: :symbol
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
	id = row[:id]
	name = row[:first_name]

	zipcode = clean_zipcode(row[:zipcode])

	legislators = legislators_by_zipcode(zipcode)

	form_letter = erb_template.result(binding)
	
	save_thank_you_letters(id, form_letter)
end