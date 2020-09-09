require_relative '../lib/file_actions'

describe FileActions do
  describe '#get_file_paths' do
    it('returns an array of all paths to .json files in all project directories') do
      expect(FileActions.collect_file_paths).to eql(['./test_files/test1.json',
                                                     './test_files/test2.json', './test_files/test3.json'])
    end
  end

  class TestFile; include FileActions end
  let(:test_file) { TestFile.new }

  describe '#open_file' do
    it('opens the file at provided path') do
      expect(test_file.open_file('./test_files/test1.json').readchar).to eql('{')
    end
  end

  describe '#read_file_lines' do
    it('returns an array of the lines in the given file') do
      expect(test_file.read_lines(File.open('./test_files/test1.json', 'r'))).to be_instance_of(Array)
    end
  end

  describe '#count_lines' do
    it('returns the number of lines in the given file') do
      expect(test_file.count_lines(File.open('./test_files/test1.json', 'r'))).to be_instance_of(Integer)
    end
  end
end
