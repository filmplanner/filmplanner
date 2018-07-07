require 'rails_helper'

RSpec.describe Movie do
  it { should have_many(:shows) }

  describe '.key_for' do
    it 'returns the correct key' do
      expect(Movie.key_for(33)).to eq 'M33'
    end
  end

  describe '#to_key' do
    subject(:movie) { FactoryBot.create(:movie, id: 34) }

    it 'returns the correct key' do
      expect(movie.to_key).to eq 'M34'
    end
  end
end
