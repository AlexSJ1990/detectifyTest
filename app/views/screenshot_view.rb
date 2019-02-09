class ScreenshotView

  def screenshot_menu
    puts ""
    puts "          What type of data are you uploading?"
    puts ""
    puts "          Enter 1 to enter urls via the terminal"
    puts "          Enter 2 to give the filepath of a csv file of urls"
    puts "          Enter 3 to give the filepath of a json of urls)"
    puts ""
    puts "===>"
    gets.chomp
  end

  def ask_for_info(info)
    puts "#{info}"
    puts "===>"
    gets.chomp
  end

  def print_info(info)
    puts "#{info}"
  end

  def print_success
    puts "it worked!"
  end

  def print_failure
    puts "it didn't work"
  end
end

