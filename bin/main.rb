require_relative '../lib/file_actions'
require_relative '../lib/file_to_check'
require_relative '../lib/line_to_check'
require_relative '../lib/assign_color'

paths = FileActions.get_file_paths

paths.each do |path| 
  file = FileToCheck.new path
  lines_array = file.read_lines(file.open_file(path))
  lines_array.each_with_index do |line, index|
    current_line = LineToCheck.new(path, index + 1, line)
    current_line.check_line
  end
end

puts Color.cyan("******************** Begin JSON Linters Report ******************")
if LineToCheck.results.empty?
  puts Color.green("All looks good. No issues found")
else
  no_of_issues = LineToCheck.results.length
  puts LineToCheck.results
  puts Color.red("#{no_of_issues} issue#{no_of_issues > 1 ? "s" : ""} found!")
end
puts Color.cyan("********************* End JSON Linters Report *******************")