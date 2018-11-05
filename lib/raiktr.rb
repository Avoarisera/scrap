require 'csv'
require 'json'

CSV.open("jeprie.csv", "w") do |csv| #open new file for write
  JSON.parse(File.open("emails.json").read).each do |hash| #open json to parse
    csv << hash.values #write value to file
  end
end