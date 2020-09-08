require 'find'

module FileActions
  def self.get_file_paths
    files = []
    Find.find('./') do |path|
      files << path if File.extname(path) == '.json'
    end
    files
  end

  def open_file(path)
    file = File.open(path, 'r')
  end

  def read_lines(file)
    file.readlines(chomp: true)
  end

  def count_lines(file)
    file.readlines.size
  end
end
