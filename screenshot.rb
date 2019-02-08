require 'watir'
require 'csv'
require 'json'
require 'date'
require_relative 'db'

class Screenshot
  # TODO: need to get the user to name the files they are sending e.g. "Monday Screenshots"
  # then when they want to retrieve, you'll have to present all their file_ref names so that they can choose
  attr_reader :files
  def initialize(data_description, data, file_ref)
    @data_description = data_description
    @data = data
    @files = []
    @user_id = nil
    @file_ref = file_ref
  end

  def parse_or_screenshot
    # need to get user to say whether url or csv or json
    # if so, need to pass the path of the file
    if @data_description == "url"
      take_screenshot(@data)
    elsif @data_description == "csv"
      get_urls_from_file(parse_csv)
    elsif @data_description == "json"
      get_urls_from_file(parse_json)
      # this code needs to be separated
      @files.each do |file|
        @img = file
        blob = SQLite3::Blob.new @img.to_s
        DB.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", blob, @user_id)
      end
      p DB.execute("SELECT * FROM screenshots")
    end
  end

  private

  def get_urls_from_file(data)
    data.each do |item|
      take_screenshot(item)
    end
  end

  def take_screenshot(url)
    browser = Watir::Browser.new

    match_data = url.match(/((http|https):\/\/www.|www.)(?<website>(\w+))..+/)
    website_name = match_data[1]
    browser.goto url

    screenshot = browser.screenshot.save "images/#{website_name} - #{DateTime.now.strftime("%e %b %Y %H:%M:%S%p")}.png"
    @files << screenshot
    # p @files

    # p DB.execute("SELECT file FROM screenshots")
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

# p Screenshot.new('csv', 'urls.csv').parse_or_screenshot
new = Screenshot.new('json', 'urls.json', 'monday files').parse_or_screenshot

