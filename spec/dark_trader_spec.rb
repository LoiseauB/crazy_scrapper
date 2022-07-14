require_relative '../lib/dark_trader'
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/").read)

describe "the tokens list" do  
  it "There is 20 tokens in the list" do
    expect(list_token(page).length).to eq(20)
  end
end

describe "the prices list" do  
  it "There is 20 prices in the list" do
    expect(list_prices(page).length).to eq(20)
  end
end

describe "class of trade" do
  it "Is trade is an array" do
    expect(tradding(["BTC"],[2.55]).class).to eq(Array) 
  end
  it "There is hash in the trade array" do
    expect(tradding(["BTC"],[2.55]).map{|element| element.class}).to eq([Hash])
  end
end