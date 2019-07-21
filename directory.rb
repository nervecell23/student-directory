@students = []

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def show_students
  print_header()
  print_students_list(@students)
  print_footer(@students)
end

def process(selection)
  case selection
  when "1"
    @students = input_students()
  when "2"
    show_students()
  when "3"
    save_students()
  when "9"
    exit
  else
    puts "I don't know what you mean, try again."
  end
end

# Interactive menu
def interactive_menu
  loop do
    print_menu()
    process(gets.chomp)
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

def print_students_list(names)
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
