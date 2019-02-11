class Screenshot
  # TODO: need to get the user to name the files they are sending e.g. "Monday Screenshots"
  # then when they want to retrieve, you'll have to present all their file_ref names so that they can choose
  # attr_reader :files
  attr_reader :data, :file_name, :file_group_name, :user_id
  def initialize(attr = {})
    @id = attr[:id]
    @data_description = attr[:data_description]
    @data = attr[:data]
    @file_name = attr[:file_name]
    @file_group_name = attr[:file_group_name]
    @user_id = nil
  end
end
