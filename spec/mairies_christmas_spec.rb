require_relative '../lib/mairies_christmas'
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/val-d-oise.html").read)

describe "the town list" do  
  it "There is 185 cities in the list" do
    expect(city_name(page).length).to eq(185)
  end
  it "There is PARMAIN in the list" do
    expect((city_name(page)).include?("PARMAIN")).to eq(TRUE)
  end
end

describe "the emails list" do  
  it "There is 185 emails in the list" do
    city_name = page.xpath('//a[@class="lientxt"]').map(&:content)
    expect(find_email(city_name).length).to eq(185)
  end
  it "Is-it the good adress?" do
    expect(find_email(["VILLIERS LE BEL"])).to eq(["secretariatgeneral@ville-villiers-le-bel.fr"])
  end
end

describe "final list" do
  it "Is trade is an array" do
    expect(final_list(["BTC"],[2.55]).class).to eq(Array) 
  end
  it "There is hash in the trade array" do
    expect(final_list(["BTC"],[2.55]).map{|element| element.class}).to eq([Hash])
  end
end