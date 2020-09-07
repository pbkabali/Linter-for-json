require_relative '../lib/file_to_check'

describe FileToCheck do
  let(:test_file) { FileToCheck.new './test_files/test1.json' }

  describe '#initialize' do
    it ('puts the file path into the path property on instantiation') do
      expect(test_file.path).to eql('./test_files/test1.json')
    end
  end

  describe '#mixins' do
    it ('gets the readline method from the FileActions mixin') do
      expect(test_file.read_lines(test_file.open_file(test_file.path))).to be_instance_of(Array)
    end
  end

end