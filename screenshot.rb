require 'watir'


def take_screenshot(url)
  browser = Watir::Browser.new

  filename = DateTime.now.strftime("%d%b%Y%H%M%S")

  urls = "https://www.google.com"

  match_data = url.match(/(https:\/\/www.|www.)(?<website>(\w+))..+/)
  website_name = match_data[1]

  browser.goto url

  browser.screenshot.save "images/#{website_name}.png"
end
