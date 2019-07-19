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
  names.each_with_index do |name, index|
    puts "#{index+1}.#{name[:name]} (#{name[:cohort]} cohort)"
  end
end

def print_wrt_firstletter(students)
  puts "Choose a letter"
  letter = gets.chomp
  print_header()
  students.select{ |student| student[:name][0] == letter}.each do |selected_student|
    puts "#{selected_student[:name]} (#{selected_student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Nothing happens until we call the methods
students = input_students()
print_wrt_firstletter(students)
print_footer(students)
