require 'watir'
require 'csv'
require 'json'
require 'date'

def take_screenshot(url)
  browser = Watir::Browser.new

  match_data = url.match(/((http|https):\/\/www.|www.)(?<website>(\w+))..+/)
  website_name = match_data[1]

  browser.goto url

  browser.screenshot.save "images/#{website_name} - #{DateTime.now.strftime("%e %b %Y %H:%M:%S%p")}.png"
end



filepath = 'urls.csv'

def parse_csv(filepath)
  CSV.foreach(filepath) do |row|
    "#{row[0]}"
  end
end

parse_csv(filepath)

filepath = 'urls.json'
def parse_json(filepath)
  serialized_urls = File.read(filepath)
  results = JSON.parse(serialized_urls)
  results
end

json_data = parse_json(filepath)
p json_data["urls"].values

def parse_text

end
