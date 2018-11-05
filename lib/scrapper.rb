
require 'open-uri'
require 'nokogiri'
require 'json'
require "google_drive"
#class Scrapp

def get_the_email_of_a_townhal_from_its_webpage(page_url)
    doc = Nokogiri::HTML(open(page_url))
    email = doc.css(".tr-last")[3].text.split(" ")[2]
    email
end


def get_all_the_urls_of_val_doise_townhalls(page_url)
    doc = Nokogiri::HTML(open(page_url))
    urls = []

    get_urls = doc.css("a[class=lientxt]")
    get_urls.each{|link| urls.push("http://annuaire-des-mairies.com"+link['href'][1...link['href'].length])}
    urls
end


def get_email()
    mairies = []
    tab_link = get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")
    tab_link.each do
        |link|
        mairie = Nokogiri::HTML(open(link)).css('main h1')[0].text.split(" ")[0]
        mairies.push({
            :name => mairie,
            :email => get_the_email_of_a_townhal_from_its_webpage(link)
        })
           
    end
  
    return mairies
end
tab_email = get_email
# end
# exp = Scrapp.new
# puts exp.get_email()

#et on affiche le resultat
# tab_email = get_email
# puts "Début d'écriture du fichier..."
# File.open("emails.json","a") do |f|
#     f.write(tab_email.to_json)
# end


# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
session = GoogleDrive::Session.from_config("config.json")

# First worksheet of
# https://docs.google.com/spreadsheet/ccc?key=pz7XtlQC-PYx-jrVMJErTcg
# Or https://docs.google.com/a/someone.com/spreadsheets/d/pz7XtlQC-PYx-jrVMJErTcg/edit?usp=drive_web
ws = session.spreadsheet_by_key("1MxRREX0anj5xNUiyrx5KzhwlIB-egMCUtlgMPM7mArs").worksheets[0]

# Gets content of A2 cell.
p ws[2, 1]  #==> "hoge"

# Changes content of cells.
# Changes are not sent to the server until you call ws.save().


ws[2, 1] = "foo"
ws[2, 2] = "bar"


i = 2 # car la premiere ligne contient les titres, les infos commencent à la ligne 2
tab_email.each do |mairie, email|
ws[i, 1] = mairie
ws[i, 2] = email
ws.save # permet de modifier et d'enregistrer le spreadsheet
i += 1 # permet de passesr à la ligne suivante
end