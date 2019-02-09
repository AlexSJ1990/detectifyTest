require_relative "../views/screenshot_view"
require_relative "../../tasks"
require_relative "../../save"

class ScreenshotsController
  def initialize
    @view = ScreenshotView.new
  end

  def retrieve
  end

  # here we are creating a screenshot
  # after creating then want to call save method
  def create
    # TODO: how do we get user_id in here
    data_description = @view.screenshot_menu
    @view.print_info("please Enter 1, 2 or 3") unless ["1", "2", "3"].include?(data_description)
    # put a path here to exit the program?
    if data_description == "1"
      answer = nil
      files = []
      until answer == ""
        @view.print_info("Please enter your urls here, if you have finished, press Return")
        answer = gets.chomp
        unless answer == ""
          answer = Task.new(answer).parse_or_screenshot(data_description, 3)
          files << answer
        end
      end
      files.each { |file| save(file, 4) }
    else
      data = @view.ask_for_info("what is the relative path of your file?")
      files = Task.new(data).parse_or_screenshot(data_description, 1)
      files.each { |file| file }
      if files.length > 1
      "#{files} are the files"
        files.each do |file|
          save(file, 1)
        end
      end
    end
  end
end

