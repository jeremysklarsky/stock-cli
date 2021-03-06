class Lookup

  def self.look_up(search)

    data = Nokogiri::HTML(open("http://www.dailyfinance.com/lookup/#{search.gsub(" ", "")}/usa"))
    results =[]
    data.search("table.table tr").each do |result|
      results << result.text.split("\n")
    end
    results.shift


    if results.size > 0
      puts ""
      puts "Did you mean any of these?"
      results.each do |stock|
        puts "Symbol: #{stock[1]}. Company: #{stock[2]}. Exchange: #{stock[3]}"
      end
      puts ""
    else
      puts "Sorry, no results found."
    end

  end
end