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

  def people_also_viewed

    @stock_doc.search("div.yui-g yfi_related_tickers a").collect do |competitor|

      competitor.text
    end
  end

  def get_headlines
    headline_array = [] 
    headlines_doc = Nokogiri::HTML(open("http://finance.yahoo.com/q/h?s=#{@ticker}+HEADLINES"))
    headlines_doc.search("div.mod.yfi_quote_headline.withsky li").each do |article|      
      headline_array << [article.search("a").first.text, 
                        article.children.first.attribute("href").value.split("*").last,
                        article.children.last.text]

    end
    headline_array

  end
 
end
