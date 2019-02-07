require 'watir'
require 'csv'
require 'json'
require 'date'

class Screenshot
  def initialize(data_description, data)
    @data_description = data_description
    @data = data
  end

  def parse_or_screenshot
    # need to get user to say whether url or csv or json
    # if so, need to pass the path of the file
    if @data_description == "url"
      take_screenshot(@data)
    elsif @data_description == "csv"
      parse_csv(@data)
    elsif @data_description == "json"
      parse_json(@data)
    end
  end

  def take_screenshot(url)
    browser = Watir::Browser.new

    match_data = url.match(/((http|https):\/\/www.|www.)(?<website>(\w+))..+/)
    website_name = match_data[1]
    browser.goto url

    screenshot = browser.screenshot.save "images/#{website_name} - #{DateTime.now.strftime("%e %b %Y %H:%M:%S%p")}.png"
  end

  def parse_csv
    urls = []
    CSV.foreach(@data) do |row|
      urls << row[0]
    end
    urls
  end

  def parse_json
    serialized_urls = File.read(@data)
    results = JSON.parse(serialized_urls)
    results["urls"].values
  end
end

# p Screenshot.new('csv', 'urls.csv').parse_csv
# p Screenshot.new('json', 'urls.json').parse_json
