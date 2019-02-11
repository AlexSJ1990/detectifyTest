require_relative "../views/screenshot_view"
require_relative "../../tasks"
require_relative "../../save"
require_relative "../models/users"
require_relative "../models/screenshots"

class ScreenshotsController
  def initialize(user)
    @view = ScreenshotView.new
    @user = user
  end

  def retrieve
    # each time you save you want to create a new file that you can retrieve
    # give them back the folder that they can go to to get their screenshot
    p @user.id
    load_files(@user.id)
  end

  # here we are creating a screenshot
  # after creating then want to call save method
  def save_files(files)
    if files.length > 1
      files.each do |file|
        # p file
        # p file.data
        # p file.file_name
        # p file.user_id
        # p @save_path
        # #<Screenshot:0x00007fb8de17d718
        # # @data=#<File:images/google - 11 Feb 2019 10:29:36AM.png (closed)>,
        # #@file_name="www.google.com - 11 Feb 2019 10:29:36AM.png", @file_group_name="w", @user_id=nil>
        save(file.data, file.file_name, @save_path, @user.id)
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
    @save_path = @view.ask_for_info("        Please enter a name to identify your collection of files")
    # put a path here to exit the program?
    if data_description == "1"
      answer = nil
      files = []
      until answer == ""
        @view.print_info("        Please enter your urls here, if you have finished, press Return")
        answer = gets.chomp
        url = answer
        unless answer == ""
          answer = Task.new(answer).parse_or_screenshot(data_description, @user.id)
          @image_name = "#{url} - #{DateTime.now.strftime("%e %b %Y %H:%M:%S%p")}.png"
          files << Screenshot.new(data: answer, file_name: @image_name, file_group_name: @save_path, user_id: @user.id)
        end
      end
      save_files(files)
    else
      data = @view.ask_for_info("       what is the relative path of your file?")
      files = Task.new(data).parse_or_screenshot(data_description, @user.id)
      save_files(files)
    end
  end
end
