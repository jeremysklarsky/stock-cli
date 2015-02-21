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



  def competition
    @competition_html = open("https://finance.yahoo.com/q/co?s=#{@ticker}+Competitors")
    @competition_doc = Nokogiri::HTML(@competition_html)
    result = []
    @competition_doc.search("th.yfnc_tablehead1").collect do |company|
      case company.text
      when ""
        nil
      when ticker.upcase
        nil
      when "Industry"
        nil
      else
        result << company.text
      end
    end
    result[0..2].join(', ')
  end

  def get_headlines
    headline_array = [] 
    headlines_doc = Nokogiri::HTML(open("http://finance.yahoo.com/q/h?s=#{@ticker}+HEADLINES"))
    headlines_doc.search("div.mod.yfi_quote_headline.withsky li").each do |article|      
      headline_array << [article.search("a").first.text, 
                        article.children.first.attribute("href").value.split("*").last,
                        article.children.last.text]

    end
    headline_array[0..9]

  end
 
end
