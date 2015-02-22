class Lookup

  # def self.look_up(search)
  #   data = JSON.parse(RestClient.get("http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=#{search}&callback=YAHOO.Finance.SymbolSuggest.ssCallback"))
  # end

  def self.look_up(search)
    # data = Nokogiri::HTML(open("http://www.marketwatch.com/tools/quotes/lookup.asp?siteID=mktw&Lookup=#{search}&Country=us&Type=All"))
    # results =[]
    # data.search("div.results tr").each do |result|
    #   results << [result.search("td.bottomborder").first.text, 
    #               result.search("td.bottomborder")[1].text,
    #               result.search("td.bottomborder")[2].text]
    term = search.gsub(" ", "")
    data = Nokogiri::HTML(open("http://www.dailyfinance.com/lookup/#{term}/usa"))
    results =[]
    data.search("table.table tr").each do |result|
      results << result.text.split("\n")
    end
    results.shift
    if results.size > 0
      results.each do |stock|
        puts "Symbol: #{stock[1]}. Company: #{stock[2]}. Exchange: #{stock[3]}"
      end
    else
      puts "Sorry, no results found."
    end

  end
end