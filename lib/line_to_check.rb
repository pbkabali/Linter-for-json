class LineToCheck
  attr_reader :value
  @@results_array = []
  def initialize(path, line_number, value)
    @path= path
    @line_number = line_number
    @value = value
  end

  def check_line
    @@results_array << "#{@path} line# #{@line_number} Trailing space detected" if trailing_space?
  end

  def trailing_space?
    @value[-1] == " "
  end

  def self.results
    @@results_array
  end
  
end