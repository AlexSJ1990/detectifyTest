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
    # p @user.id
    load_files(@user.id)
  end

  def save_files(files)
    if files.length > 1
      files.each do |file|
        save(file.data, file.file_name, @save_path, @user.id)
      end
    elsif files.length == 1
      file = files.first
      save(file.data, file.file_name, @save_path, @user.id)
    else
      puts @view.print_info("       Please try again, there appear to be no urls")
    end
  end

  def create_files_from_cli_or_file
    @data_description = @view.screenshot_menu
    create_files_from_cli_or_file unless ["1", "2", "3"].include?(@data_description)
    @save_path = @view.ask_for_info("        Please enter a name to identify your collection of files")
    @data_description == "1" ? create_from_cli : create_from_file
  end

  def create_from_cli
    answer = nil
    files = []
    until answer == ""
      @view.print_info("        Please enter your urls here, if you have finished, press Return")
      answer = gets.chomp
      url = answer
      unless url.match(/((http|https):\/\/www.|www.)(?<website>(\w+))..+/) || url == ""
        @view.print_info("        incorrect url please retry")
        create_from_cli
      else
        unless answer == ""
          answer = Task.new(answer).parse_or_screenshot(@data_description, @user.id)
          @image_name = "#{url} - #{DateTime.now.strftime("%e %b %Y %H:%M:%S%p")}.png"
          files << Screenshot.new(data: answer, file_name: @image_name, file_group_name: @save_path, user_id: @user.id)
        end
      end
    end
    save_files(files)
  end

  def create_from_file
    data = @view.ask_for_info("       what is the relative path of your file?")
    # TODO need to handle exception here !!!
    files = Task.new(data).parse_or_screenshot(@data_description, @user.id)
    s_files = []
    files.each do |file|
      s_files << Screenshot.new(data: file, file_name: "test", file_group_name: @save_path, user_id: @user.id)
    end
    s_files
    save_files(s_files)
  end
end
