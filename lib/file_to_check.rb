require_relative './file_actions'
require_relative './assign_color'

class FileToCheck
  include FileActions
  include Color
  @@results_array = []
  attr_reader :path

  def initialize(path)
    @path = path
    @curly_braces = 0
    @curly_braces_rising = true
    @square_brackets = 0
    @square_brackets_rising = true
  end

  def check_file
    unless braces_closed?.empty?
      braces_closed?.each do |pos|
        @@results_array << "#{@path} #{yellow("line# #{pos[0]}:")} Expected a #{yellow(pos[2])}!" if pos[1]
      end 
    end
  end

  def braces_closed?
    findings = []
    lines_array = read_lines(open_file(@path))
    lines_array.each_with_index do | val, index |
      val.split('').each do |i|
        if i == '{' && @curly_braces >= 0
          @curly_braces += 1
        elsif i == '}' && @curly_braces > 0
          @curly_braces -= 1
        elsif i == '}' && @curly_braces == 0
          findings << [index, true, "'{'"]
          @curly_braces = 0
        elsif i == '[' && @square_brackets >= 0
          @square_brackets += 1
        elsif i == ']' && @square_brackets > 0
          @square_brackets -= 1
        elsif i == ']' && @square_brackets == 0
          findings << [index, true, "'{'"]
          @square_brackets = 0
        end
      end
    end
    findings << [count_lines(open_file(@path)), true, "'{'"] if @curly_braces < 0
    findings << [count_lines(open_file(@path)), true, "'}'"] if @curly_braces > 0
    findings << [count_lines(open_file(@path)), true, "'['"] if @square_brackets < 0
    findings << [count_lines(open_file(@path)), true, "']'"] if @square_brackets > 0
    findings
  end

  def self.results
    @@results_array
  end

end