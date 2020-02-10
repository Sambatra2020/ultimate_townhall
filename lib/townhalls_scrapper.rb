require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

=begin def ville_ain
	a = []
	crypto = Hash.new
	page1 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/ain.html")) 
	nom = page1.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td[1]/a[1]").text
		#puts x['href']
		#puts x.text
	
	page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/01/amberieu-en-bugey.html")) 
	mail = page2.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
		#puts y['href']
		#puts y.text
	
	crypto[nom] = mail
	a.push(crypto) 
	puts a
=end
#def ville_ain_mail 
	#	page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/01/amberieu-en-bugey.html")) []

	#	page2.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td").each do |mail|
			
		#end
	#end
	class Scrapper
		@@hash = Hash.new
		@@hash1 = Hash.new		
		@@hash2 = Hash.new
		@@hash3 = Hash.new
		attr_accessor :hash, :hash1, :hash2, :hash3
		@@nomville = []
		@@lien = []

		def ville_ain_nom
			page1 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/ain.html")) 
			page1.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td/a").each do |nom|
			#puts nom['href']
			#puts nom.text
			@@hash[nom.text] = nom['href']
			@@nomville << nom.text
			@@lien << nom['href']

			end
			#puts @@hash
=begin
			@@hash.each { |key,value|
				html = "http://annuaire-des-mairies.com/"
				html << value
				page1 = Nokogiri::HTML(open(html)) 
				az = page1.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				mail = az.text
				@@hash1[key] = mail 
			}
			puts @@hash1
=end
			for i in 1..170
				html = "http://annuaire-des-mairies.com/" + @@lien[i]
				page1 = Nokogiri::HTML(open(html)) 
				az = page1.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				mail = az.text
				@@hash1[@@nomville[i]] = mail 
			end
			#puts @@hash1
		end

		def ville_aisne
			page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/aisne.html")) 
			page2.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td/a").each do |nom|
				@@hash[nom.text] = nom['href']
				@@nomville << nom.text
				@@lien << nom['href']
			end
			#puts @@lien
			for i in 1..100
				html = "http://annuaire-des-mairies.com/" + @@lien[i]
				page2 = Nokogiri::HTML(open(html))
				real = page2.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				email = real.text
				@@hash2[@@nomville[i]] = email 
  			end
  			#puts @@hash2
		end
		def alpes_de_haute_provence
			page3 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/alpes-de-haute-provence.html")) 
			page3.xpath("/html/body/div/main/section[3]/div/table/tbody/tr/td/a").each do |nom|
				@@hash[nom.text] = nom
				@@nomville << nom.text
				@@lien << nom['href']
			end
			#puts @@lien	
			for i in 1..95
				html = "http://annuaire-des-mairies.com/" + @@lien[i]
				page3 = Nokogiri::HTML(open(html))
				om = page3.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
				email = om.text
				@@hash3[@@nomville[i]] = email 
	  		end
  		#puts @@hash3
		end
		def fgh
		  @@hash = @@hash1.merge(@@hash2)
		  @@hash = @@hash.merge(@@hash3)
		  puts @@hash
		  return @@hash

		end
		
	File.open("/home/eric/ultimate_townhall/db/townhalls.json","w") do |F|
	F.write(@@hash.to_json)
end
	end
	p = Scrapper.new
	p.ville_ain_nom
	p.ville_aisne
	p.alpes_de_haute_provence
	p.fgh

	