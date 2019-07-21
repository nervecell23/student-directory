@students = []

def save_students
  puts "What is the name of the file?"
  filename = gets.chomp
  File.open(filename, "w") do |file|
  # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    puts "Students list now saved to file."
  end
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    return
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
  when "4"
    load_students()
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

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort, hobby, dob = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, hobby: hobby, country: dob}
    end
  end
end

def input_students
  puts "Enter the name of the students, their cohort, their hobbies, country of birth with space"
  puts "To finish, hit return twice"
  students = []
  info = gets.chomp
  while !info.empty? do
    name, cohort, hobby, dob = info.split(" ")
    students << {name: name, cohort: cohort, hobby: hobby.to_sym, country: country}
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
try_load_students()
interactive_menu()
