require 'nokogiri'
require 'open-uri'

# //*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a
def get_depute_email(depute_url)
  page = Nokogiri::HTML(URI.open(depute_url))
  page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
end


def final_array

list_first_name = []
list_last_name = []
list_url = []

page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
page.xpath('//div[contains(@class, "clearfix col-container")] //a').each do |depute|
  list_first_name << depute.text.split[1] 
end

page.xpath('//div[contains(@class, "clearfix col-container")] //a').each do |depute|
  list_last_name << depute.text.split[2] 
end

page.xpath('//div[contains(@class, "clearfix col-container")] //a').each do |depute|
  list_url << depute['href']
end

#👽👽👽    final_array = list_first_name.zip(list_last_name, mail).map{|f, l, e| {k => v => e} ?? 


 number_of_depute = list_first_name.length - 1
 final_array = []
 
 for i in 0..number_of_depute
  mail = get_depute_email("https://www2.assemblee-nationale.fr/#{list_url[i]}")
  final_array << {"first_name"=> list_first_name[i], "last_name"=> list_last_name[i], "email"=> mail}
 end
 
 return final_array
 
end

print final_array