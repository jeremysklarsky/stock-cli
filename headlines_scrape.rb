require 'nokogiri'
require 'pry'
require 'open-uri'

# #Headline news (first-text)
# apple.search("div.mod.yfi_quote_headline.withsky li a").first.text

# #Headline link
# apple.search("div.mod.yfi_quote_headline.withsky li a").first.attribute("href").value
# headlines = {text => link}

#headline source
#apple.search("div.mod.yfi_quote_headline.withsky li cite").first.text

stock_html = open("http://finance.yahoo.com/q/h?s=AAPL+Headlines")
stock_doc = Nokogiri::HTML(stock_html)
empty_hash = {}

stock_doc.search("div.mod.yfi_quote_headline.withsky li").each do |article|
  empty_hash[article.text] =  { :link => article.children.first.attribute("href").value,
                                :source => article.children.last.text
                              }
end
