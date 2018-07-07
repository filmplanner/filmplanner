require 'rails_helper'

RSpec.describe SuggestionKey do
  describe '.join' do
    it 'combines multiple keys' do
      expect(SuggestionKey.join(['M1', 'M3'])).to eq 'M1-M3'
      expect(SuggestionKey.join(['M1', 'M3', 'M3'])).to eq 'M1-M3'
      expect(SuggestionKey.join(['M4', 'M1', 'M3', 'M3'])).to eq 'M1-M3-M4'
    end
  end

  describe '.split' do
    it 'splits key to subkeys' do
      expect(SuggestionKey.split('M1-M3-M4')).to eq ['M1', 'M3', 'M4']
    end
  end

  describe '#to_s' do
    subject(:suggestion_key) { SuggestionKey.new('M1-M3-M4') }

    it 'returns the correct key' do
      expect(suggestion_key.to_s).to eq 'M1-M3-M4'
    end
  end

  describe '#keys' do
    subject(:suggestion_key) { SuggestionKey.new('M1-M3-M4') }

    it 'returns the correct keys' do
      expect(suggestion_key.keys).to eq ['M1', 'M3', 'M4']
    end
  end

  describe '#all_keys' do
    subject(:suggestion_key) { SuggestionKey.new('M1-M3-M4') }

    it 'returns the correct keys' do
      expect(suggestion_key.all_keys).to eq ['M1', 'M3', 'M4', 'M1-M3', 'M1-M4', 'M3-M4', 'M1-M3-M4']
    end
  end

  describe '#ids' do
    subject(:suggestion_key) { SuggestionKey.new('M1-M3-M4') }

    it 'returns the correct ids' do
      expect(suggestion_key.ids).to eq [1, 3, 4]
    end
  end
end
