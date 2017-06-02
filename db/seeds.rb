# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'On clear les avocats'
Avocat.destroy_all

puts 'On récupere les adresses des avocats'

store = []
for i in (1..5) do
html_doc = Nokogiri::HTML(open("http://www.avocatsparis.org/Eannuaire/CMSListeRecherche.aspx?nom=&Pre=&ChReNom=2&Adr=&Arr=-1&mail=False&Site=False&Toque=&etranger=False&Spec=25&page=#{i}"), nil, 'UTF-8')
html_doc.search('.corps3newannuaire\"').each do |info|
  avocat = {}
  avocat[:name] = info.search('.lien3').first.search('strong').text
  avocat[:address] = info.search('.newannuair10px')[2].text
  store << avocat
  end
end
  store.each do |avocat|
  Avocat.create(avocat)
end
