class Router
  def initialize
    @running = true
  end

def run
  puts "Welcome to our url to screenshot app!"
  puts "           --           "
  while @running
    display_tasks
    action = ask_action
    route_action(action)
  end
end

private

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - Enter urls"
    puts "2 - "
    puts "3 - Exit the program"
  end

  def route_action(action)
    case action
    when 1 then
    when 2 then
    when 3 then stop
    else
      puts "Please press 1, 2, or 3"
    end
  end

  def ask_action
    puts "What do you want to do next?"
    print "> "
    gets.chomp.to_i
  end

   def stop
    @running = false
  end
end
