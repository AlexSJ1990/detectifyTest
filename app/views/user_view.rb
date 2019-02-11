class UserView
  def get_info(info)
    puts "        #{info}"
    gets.chomp
  end

  def print_info(info)
    puts "        #{info}"
  end

  def puts_space
    28.times do
      puts ""
    end
  end
end
