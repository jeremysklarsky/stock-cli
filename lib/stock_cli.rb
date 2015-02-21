require 'pry'
require 'open-uri'

class StockCLI


  def initialize
    puts "Welcome to Stocks"
  end

  def call
    
    display_stock_info
  end

  def display_stock_info
    puts "Enter a stock's ticker symbol."
    input = gets.strip  
    scrape = Scraper.new(input)

    stock = StockQuote::Stock.quote("#{input}")
    puts "Current Price: #{scrape.current_price}"
    puts "Change: #{stock.change} (#{stock.changein_percent})"  
    puts "Prev. Close: #{stock.previous_close}. Open: #{stock.open}"
    puts "Bid: #{stock.bid_realtime}. Ask: #{stock.ask_realtime}"
    puts "Earnings date: #{scrape.earnings_date}"
    puts "Day's Range: #{stock.days_range}. Year's Range: #{stock.year_range}"
    puts "Volume: #{stock.volume.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{','}")}"
    puts "Market Cap: #{stock.market_capitalization}"
    puts "P/E Ratio: #{stock.pe_ratio}. Earnings per share: #{stock.earnings_share}"
    stock.dividend_share != 0.0 ? (puts "Div. and Yield: #{stock.dividend_share} (#{stock.dividend_yield}%)") : (puts "No Dividend")
    puts "Similiar companies: #{scrape.competition}"

    scrape.get_headlines.each.with_index(1) do |article, i|
      puts "#{i}. #{article[0]}: #{article[2]}"
    end
    # binding.pry

    puts "Enter a number to open an article in your browser."
    selection = gets.strip.to_i - 1
    # binding.pry
    # system(open "#{scrape.get_headlines[selection][1]}")
    open_page(scrape.get_headlines[selection][1])
  end

 

  def stock_menu(stock)
    puts "Enter a number to select:"
    puts "1. View similar companies"
    puts "2. View headlines about #{stock}"
    puts "3. View a new stock"
  end

  def stock_menu_selection
  end

  def open_page(url)
    system("open", url)
  end
  
end
