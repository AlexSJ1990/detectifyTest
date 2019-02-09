class Screenshot
  # TODO: need to get the user to name the files they are sending e.g. "Monday Screenshots"
  # then when they want to retrieve, you'll have to present all their file_ref names so that they can choose
  # attr_reader :files
  def initialize(attr = {})
    @data_description = attr[:data_description]
    @data = attr[:data]
    # @files = []
    @user_id = nil
    # @file_ref = attr[:file_ref]
  end
end
