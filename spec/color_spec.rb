require_relative '../lib/color'

describe Color do
  let(:color_code) { 31 }
  let(:value) { 'Error message' }

  describe '#add_color' do
    it('returns color coded string') do
      expect(Color.add_color(color_code, value)).to eql("\e[#{color_code}m#{value}\e[0m")
    end

    it('does not need a string to return a string') do
      expect(Color.add_color(color_code, 4)).to_not be_instance_of(Integer)
    end

    it('does not raise an error if supplied an integer') do
      expect { Color.add_color(color_code, 4) }.to_not raise_error
    end
  end
end
