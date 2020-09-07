require 'find'

module File_actions
  def self.get_file_paths
    files = []
    Find.find('./') do |path|
      files << path if File.extname(path) == '.json'
    end
    files
  end
end
