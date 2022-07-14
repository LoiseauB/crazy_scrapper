require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/val-d-oise.html").read)

def city_name(page)
  city_name = page.xpath('//a[@class="lientxt"]').map(&:content)
  return city_name
end

def find_email(city_name)
  town_emails = []
  city_name.each do |town|
    town = town.tr(' ', '-')
    city_page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/95/#{town.downcase}.html").read)
    email = city_page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').map(&:content).join
    town_emails.push(email)
  end
  #puts town_emails
  return town_emails
end

def final_list(city_name,town_emails)
  mix = city_name.zip(town_emails)
  final_list = []
  mix.each do |city , mail|
    final_list.push(Hash.try_convert({city=>mail}))
  end
  #puts final_list
  return final_list
end

def perform(page)
  city_name = city_name(page)
  town_emails = find_email(city_name)
  final_list(city_name,town_emails)
end

perform(page)