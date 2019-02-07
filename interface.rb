require_relative 'screenshot'

answer = nil
url_array = []

  until answer == ""
    puts "Hello type your url's here to get screenshots, if you have finished entering click return"
    answer = gets.chomp
    url_array << answer unless answer == ""
  end

url_array.each do |url|
  take_screenshot(url)
end
