class Lookup

  def self.look_up(search)
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