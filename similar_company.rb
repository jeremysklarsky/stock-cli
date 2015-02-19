require 'nokogiri'
require 'open-uri'
require 'pry'
#text

stock_html = open("http://finance.yahoo.com/q/co?s=AAPL")
stock_doc = Nokogiri::HTML(stock_html)

a = stock_doc.search("table.yfnc_datamodoutline1 th.yfnc_tablehead1 a").collect do |company|
  company.text
  #please get rid of same company and/or industry
end

binding.pry
