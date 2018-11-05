require "google_drive"
require 'gmail'

class Mailer
  
    def initialize 
  
    #   session = GoogleDrive::Session.from_config("config.json")
    #   ws = session.spreadsheet_by_key("GjY5opn6bF_0JMw2VtUqAK9M").worksheets[0]
  
  
    # lim = ws.num_rows
    #   for i in 2..lim 

        gmail = Gmail.connect("fitestena@gmail.com", "test@sayna")

        gmail.deliver do
            to "jenrandr@gmail.com"
            subject "The Hacking Project"
            text_part do
              body "Bonjour,
              Je m'appelle Jeni, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.
              
              Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de veut changer le monde avec nous ?        
              
              Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
            end
            charset = "UTF-8"
        end
    
        gmail.logout
        

      end
  
    end

    mail = Mailer.new