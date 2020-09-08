require_relative '../lib/assign_color'

describe Color do

  let(:color_code) { 31 }
  let(:value) { 'Error message' }

  describe '#add_color' do
    it ('returns color coded string') do
      expect(Color.add_color(color_code, value)).to eql("\e[#{color_code}m#{value}\e[0m")
    end
  end
end