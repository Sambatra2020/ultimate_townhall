require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'gmail'
require 'dotenv'
require 'json'

class Mailer
  attr_accessor :gmail

  def initialize(department)
    json = File.read("#{department}.json")
    @json_parsing = JSON.parse(json)
  end

  def authentification
    Dotenv.load('.env')
    @gmail = Gmail.connect(ENV["email"],ENV["mdp"])
  end


  def send_mail(email, city)
      @gmail.deliver do
        to email
        subject "Changez le monde avec The Hacking Project"
        text_part do
          content_type 'text; charset=UTF-8'
          body "Bonjour,
          Je m'appelle Franklin, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

          Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{city} veut changer le monde avec nous ?

          Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
        end
      end  
    end

    # Lancement
  def perform
    authentification
    @json_parsing.each  do |city, email|
        send_mail(email, city)
    end
  end
end


#send_mail = Mailer.new("./db/townhalls.json")           #(pour lancer le mailing :D)
#send_mail.perform