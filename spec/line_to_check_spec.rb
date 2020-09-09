require_relative '../lib/line_to_check'
require_relative '../lib/file_to_check'

describe LineToCheck do

  let(:test_file) { FileToCheck.new './test_files/test1.json' }
  let(:file_array) { test_file.read_lines(test_file.open_file(test_file.path)) }
  let(:test_line) { LineToCheck.new(test_file.path, 2, file_array[1]) }
  let(:test_line1) { LineToCheck.new(test_file.path, 3, file_array[2]) }
  let(:test_file2) { FileToCheck.new './test_files/test2.json' }
  let(:file_array2) { test_file2.read_lines(test_file2.open_file(test_file2.path)) }
  let(:test_line2) { LineToCheck.new(test_file2.path, 1, file_array2[0]) }
  
  describe '#initialize' do
    it('puts the line value in the value property on instantiation') do
      expect(test_line.value).to eql('  "name": "Polos", ')
    end
  end

  describe '#check_line' do
    it('adds trailing-space warning message in results array if the line has a trailing space') do
      test_line.check_line
      expect(LineToCheck.results).to eql(["./test_files/test1.json \e[33mline# 2:\e[0m Trailing space detected!"])
    end

    it('doesn\'t add trailing-space warning message in results array if the line has no trailing space') do
      test_line2.check_line
      expect(LineToCheck.results).to eql(["./test_files/test1.json \e[33mline# 2:\e[0m Trailing space detected!"])
    end
  
    it('adds colon-space warning message in results array if the line has a bad colon spacing') do
      test_line1.check_line
      expect(LineToCheck.results).to eql(
        ["./test_files/test1.json \e[33mline# 2:\e[0m Trailing space detected!",
        "./test_files/test1.json \e[33mline# 3:\e[0m Missing space after colon at \e[33m11\e[0m!"]
      )
    end

    it('doesn\'t add colon-space warning message in results array if the line has no bad colon spacing') do
      test_line2.check_line
      expect(LineToCheck.results).to eql(
        ["./test_files/test1.json \e[33mline# 2:\e[0m Trailing space detected!",
        "./test_files/test1.json \e[33mline# 3:\e[0m Missing space after colon at \e[33m11\e[0m!"]
      )
    end
  end
end
