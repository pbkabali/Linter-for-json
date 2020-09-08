class LineToCheck
  attr_reader :value
  
  def initialize(path, line_number, value)
    @path= path
    @line_number = line_number
    @value = value
  end

  def trailing_space?
    @value[-1] == " "
  end
  
end