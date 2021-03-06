# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/MethodLength,Style/ClassVars
require_relative './file_actions'
require_relative './color'

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
    return if braces_closed.empty?

    braces_closed.each do |pos|
      @@results_array << "#{@path} #{yellow("line# #{pos[0]}:")} Expected a #{yellow(pos[2])}!" if pos[1]
    end
  end

  def self.results
    @@results_array
  end

  private

  def braces_closed
    findings = []
    lines_array = read_lines(open_file(@path))
    lines_array.each_with_index do |val, index|
      val.split('').each do |i|
        if i == '{' && @curly_braces >= 0
          @curly_braces += 1
        elsif i == '}' && @curly_braces.positive?
          @curly_braces -= 1
        elsif i == '}' && @curly_braces.zero?
          findings << [index + 1, true, "'{'"]
          @curly_braces = 0
        elsif i == '[' && @square_brackets >= 0
          @square_brackets += 1
        elsif i == ']' && @square_brackets.positive?
          @square_brackets -= 1
        elsif i == ']' && @square_brackets.zero?
          findings << [index + 1, true, "'['"]
          @square_brackets = 0
        end
      end
    end
    number_of_lines = count_lines(open_file(@path))
    findings << [number_of_lines, true, "'{'"] if @curly_braces.negative?
    findings << [number_of_lines, true, "'}'"] if @curly_braces.positive?
    findings << [number_of_lines, true, "'['"] if @square_brackets.negative?
    findings << [number_of_lines, true, "']'"] if @square_brackets.positive?
    findings
  end
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/MethodLength,Style/ClassVars
