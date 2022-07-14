require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/").read)

def list_token(page)
  token = page.xpath('//a[@class="cmc-table__column-name--symbol cmc-link"]').map(&:content)
  return token
end

def list_prices(page)
  prices = page.xpath('//a[@class="cmc-link"]/span').map(&:content)
  prices.delete("Cryptocurrencies")
  prices.delete("Community")
  prices = prices.map{ |price| price.tr('$','').tr(',','')}
  prices = prices.map { |price| price.to_f }
  return prices
end

def tradding(token,prices)

  market = token.zip(prices)
  trade = []
  market.each do |t,p|
    trade.push(Hash.try_convert({t=>p}))
  end
  puts trade
  return trade
end

def perform(page)
  token = list_token(page)
  prices = list_prices(page)
  tradding(token,prices)
end

perform(page)