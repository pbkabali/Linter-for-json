require_relative '../lib/file_to_check'

describe FileToCheck do
  let(:test_file) { FileToCheck.new './test_files/test1.json' }
  let(:test_file2) { FileToCheck.new './test_files/test2.json' }

  describe '#initialize' do
    it('puts the file path into the path property on instantiation') do
      expect(test_file.path).to eql('./test_files/test1.json')
    end
  end

  describe '#mixins' do
    it('gets the readline method from the FileActions mixin') do
      expect(test_file.read_lines(test_file.open_file(test_file.path))).to be_instance_of(Array)
    end
  end

  describe '#check_file' do
    it('adds missing brace message in results array if extra closing brace is detected') do
      test_file.check_file
      expect(FileToCheck.results).to eql(["./test_files/test1.json \e[33mline# 5:\e[0m Expected a \e[33m'{'\e[0m!"])
    end

    it('adds missing bracket message in results array if extra closing bracket is detected') do
      test_file2.check_file
      expect(FileToCheck.results).to eql(
        ["./test_files/test1.json \e[33mline# 5:\e[0m Expected a \e[33m'{'\e[0m!",
         "./test_files/test2.json \e[33mline# 1:\e[0m Expected a \e[33m'['\e[0m!"]
      )
    end
  
  end
end
