require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  attr_accessor :ticker

  def initialize(ticker)
    @ticker = ticker
  end

  def current_price
    @stock_html = open("http://finance.yahoo.com/q?s=#{@ticker}")
    @stock_doc = Nokogiri::HTML(@stock_html)  
    @stock_doc.search("span.time_rtq_ticker").text    
  end

  def earnings_date
    @stock_doc.search("td.yfnc_tabledata1")[6].text
  end
end
