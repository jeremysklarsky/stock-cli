require 'nokogiri'
require 'open-uri'


stock_html = open("http://finance.yahoo.com/q/pr?s=AAPL+Profile")
stock_doc = Nokogiri::HTML(stock_html)
stock_doc.search("td.yfnc_modtitlew1 a")[1].text

#http webpage"