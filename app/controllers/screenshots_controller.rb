require_relative "../views/screenshot_view"
require_relative "../../tasks"

class ScreenshotsController
  def initialize
    @view = ScreenshotView.new
  end

  def load
  end

  # here we are creating a screenshot
  # after creating then want to call save method
  def create
    # TODO: how do we get user_id in here
    data_description = @view.screenshot_menu
      @view.print_info("please Enter 1, 2 or 3") unless ["1", "2", "3"].include?(data_description)
      # put a path here to exit the program?
      data = @view.ask_for_info("what is the relative path of your file?") if ["2", "3"].include?(data_description)
      parse = Task.new(data).parse_or_screenshot(data_description, 1)
  end


  def save(file, user_id)
    img = file
    blob = SQLite3::Blob.new img.to_s
    save = DB.execute("INSERT INTO screenshots (file, user_id) VALUES (?, ?)", blob, user_id)
    save ? @view.print_success : @view.print_failure
  end
end
