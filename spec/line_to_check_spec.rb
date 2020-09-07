require_relative '../lib/line_to_check'

describe LineToCheck do
  let(:test_line) { LineToCheck.new '"country" : "Uganda"' }

  describe '#initialize' do
    it ('puts the line value in the value property on instantiation') do
      expect(test_line.value).to eql('"country" : "Uganda"')
    end
  end

end