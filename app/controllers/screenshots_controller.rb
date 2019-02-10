require_relative "../views/screenshot_view"
require_relative "../../tasks"
require_relative "../../save"
require_relative "../models/users"

class ScreenshotsController
  def initialize(user)
    @view = ScreenshotView.new
    @user = user
  end

  def retrieve
    # each time you save you want to create a new file that you can retrieve
    # give them back the folder that they can go to to get their screenshot
  end

  # here we are creating a screenshot
  # after creating then want to call save method
  def save_files(files)
    if files.length > 1
      files.each do |file|
        # p file
        save(file, @user.id)
      end
    elsif files.length == 1
      save(files, @user.id)
    else
      puts @view.print_info("       Please try again, there appear to be no urls")
    end
  end

  def create
    data_description = @view.screenshot_menu
    @view.print_info("        please Enter 1, 2 or 3") unless ["1", "2", "3"].include?(data_description)
    save_path = @view.ask_for_info("        Please enter the relative path where you would like to store your screenshots")
    # put a path here to exit the program?
    if data_description == "1"
      answer = nil
      files = []
      until answer == ""
        @view.print_info("        Please enter your urls here, if you have finished, press Return")
        answer = gets.chomp
        unless answer == ""
          answer = Task.new(answer).parse_or_screenshot(data_description, @user.id)
          files << answer
        end
      end
      save_files(files)
      # files.each { |file| save(file, @user.id) }
    else
      data = @view.ask_for_info("       what is the relative path of your file?")
      files = Task.new(data).parse_or_screenshot(data_description, @user.id)
      save_files(files)
      # if there are more than on file, iterate over each and save - else just save
      # if files.length > 1
      #   files.each { |file| save(file, @user.id) }
      # elsif files.length == 1
      #   save(file, @user_id)
      # else
      #   puts @view.print_info("       Please check your file, there appear to be no urls")
      # end
    end
  end
end
