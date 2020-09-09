# rubocop:disable Style/ClassVars,Layout/LineLength

require_relative './assign_color'

class LineToCheck
  include Color
  attr_reader :value
  @@results_array = []

  def initialize(path, line_number, value)
    @path = path
    @line_number = line_number
    @value = value
  end

  def check_line
    @@results_array << "#{@path} #{yellow("line# #{@line_number}:")} Trailing space detected!" if trailing_space?
    space_around_colon?&.each do |pos|
      unless pos[1]
        @@results_array << "#{@path} #{yellow("line# #{@line_number}:")} Unnecessary space before colon at #{yellow(pos[0])}!"
      end
      unless pos[2]
        @@results_array << "#{@path} #{yellow("line# #{@line_number}:")} Missing space after colon at #{yellow(pos[0])}!"
      end
    end
  end

  def trailing_space?
    @value[-1] == ' '
  end

  def space_around_colon?
    occurrences = (0...@value.length).find_all { |i| @value[i, 1] == ':' }
    return if occurrences.empty?

    findings = []
    occurrences.each do |index|
      before = if index.zero?
                 true
               else
                 @value[index - 1] != ' '
               end
      after = if index == @value.length - 1
                true
              else
                @value[index + 1] == ' '
              end
      findings << [index, before, after]
    end
    findings
  end

  def self.results
    @@results_array
  end
end
# rubocop:enable Style/ClassVars,Layout/LineLength
