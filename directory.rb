def input_students
  puts "Enter the name of the students"
  puts "To finish, hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print(names)
  print_header()
  idx = 0
  while idx < names.count do
    puts "#{names[idx][:name]} (#{names[idx][:cohort]} cohort)"
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
students = input_students()
print(students)
print_footer(students)
