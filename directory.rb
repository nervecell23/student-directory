# Interactive menu
def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students()
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

def input_students
  puts "Enter the name of the students, their cohort, their hobbies, country of birth with space"
  puts "To finish, hit return twice"
  students = []
  info = gets.chomp
  while !info.empty? do
    info_split = info.split(" ")
    name = info_split[0]
    cohort = info_split[1].to_sym
    hobby = info_split[2]
    country = info_split[3]
    students << {name: name, cohort: cohort, hobby: hobby, country: country, cohort: cohort}
    student_word = (students.count > 1)?"students":"student"
    puts "Now we have #{students.count} #{student_word}"
    info = gets.chomp
  end
  students
end

# Find existing unique cohort in the student list---------
def find_unique_cohort(students)
  students.map { |student| student[:cohort]}.uniq
end
#---------------------------------------------------------

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

# Print students and their cohort by cohort
def print_by_cohort(students)
  puts "There is no student!" if students.count == 0
  return
  print_header()
  students.group_by { |student| student[:cohort] }.each do |_, group|
    group.each { |student_in_grp| puts "#{student_in_grp[:name].center(10)} (#{student_in_grp[:cohort].to_s.center(10)} cohort)"}
  end
end

def print(names)
  idx = 0
  while idx < names.count do
    puts "#{names[idx][:name].center(10)} (#{names[idx][:cohort]} cohort) from #{names[idx][:country]} loves #{names[idx][:hobby]}"
    idx += 1
  end
end

def print_wrt_firstletter(students)
  puts "Choose a letter"
  letter = gets.chomp
  print_header()
  students.select{ |student| student[:name][0] == letter}.each do |selected|
    puts "#{selected[:name]} (#{selected[:cohort]} cohort)"
  end
end

def print_wrt_size(students)
  print_header()
  students.select{|student| student[:name].size < 12}.each do |selected|
    puts "#{selected[:name]} (#{selected[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Nothing happens until we call the methods
interactive_menu()
