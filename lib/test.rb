require 'json'
tab = ["bonjour", "tous", "le", "monde"]
File.open("emails.json","a") do |f|
    tab.each do |item|
        f.write(item.to_json)
    end
end