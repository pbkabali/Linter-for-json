require_relative '../lib/file_actions'

describe File_actions do
  describe '#get_file_paths' do
    it ('returns an array of all paths to .json files in all project directories') do
      expect(File_actions.get_file_paths).to eql(["./test_files/test1.json", "./test_files/test2.json"])
    end
  end
end