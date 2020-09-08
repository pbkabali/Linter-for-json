require_relative './file_actions'

class FileToCheck
  include FileActions
  attr_reader :path

  def initialize(path)
    @path = path
  end
end