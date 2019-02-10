require 'watir'
require 'csv'
require 'json'
require 'date'
require 'selenium-webdriver'

class Task
  # TODO: data_description, data, user id as instance variables?
  def initialize(data)
    @data = data
    # @files = []
  end

  def parse_or_screenshot(data_description, user_id)
    # need to get user to say whether url or csv or json
    # if so, need to pass the path of the file
    # p "the data_description in parse or screenshot is #{data_description}"
    # p "the data in parse or screenshot is #{@data}"
    if data_description == "1"
      take_screenshot(@data)
    elsif data_description == "2"
      get_urls_from_file(parse_csv)
    elsif data_description == "3"
      get_urls_from_file(parse_json)
    end
    # @files.each do |file|
    #   save(file, user_id) # this calls out db methods
    # end
    # p DB.execute("SELECT * FROM screenshots")
  end

  private

  def get_urls_from_file(data)
    files = []
    data.each do |item|
      files << take_screenshot(item)
    end
      files
  end

  def take_screenshot(url)
    browser = Watir::Browser.new(:chrome,
      {:chromeOptions => {:args => ['--headless', '--window-size=1200x600']}})
    match_data = url.match(/((http|https):\/\/www.|www.)(?<website>(\w+))..+/)
    website_name = match_data[1]
    browser.goto url

    screenshot = browser.screenshot.save "images/#{website_name} - #{DateTime.now.strftime("%e %b %Y %H:%M:%S%p")}.png"
  end

  def parse_csv
    urls = []
    CSV.foreach(@data) do |row|
      # we are iterating over rows which have an Array type so an empty array
      # will be [] so don't push to urls array
      urls << row[0] unless row == []
    end
    urls
  end

  def parse_json
    serialized_urls = File.read(@data)
    results = JSON.parse(serialized_urls)
    results["urls"].values
  end
end

# p new = Task.new().parse_or_screenshot('1', 'https://www.google.com', 'files')
# p new2 = Task.new('urls.csv').parse_or_screenshot('2', 'test')
# new3 = Task.new('urls.json').parse_or_screenshot('3', 'monday files')
