require 'rails_helper'

RSpec.describe Key do
  describe '.join' do
    it 'combines multiple keys' do
      expect(Key.join(['M1', 'M3'])).to eq 'M1-M3'
      expect(Key.join(['M1', 'M3', 'M3'])).to eq 'M1-M3'
      expect(Key.join(['M4', 'M1', 'M3', 'M3'])).to eq 'M1-M3-M4'
    end
  end

  describe '.split' do
    it 'splits key to subkeys' do
      expect(Key.split('M1-M3-M4')).to eq ['M1', 'M3', 'M4']
    end
  end

  describe '#to_s' do
    subject(:key) { Key.new('M1-M3-M4') }

    it 'returns the correct key' do
      expect(key.to_s).to eq 'M1-M3-M4'
    end
  end

  describe '#keys' do
    subject(:key) { Key.new('M1-M3-M4') }

    it 'returns the correct keys' do
      expect(key.keys).to eq ['M1', 'M3', 'M4']
    end
  end

  describe '#all_keys' do
    subject(:key) { Key.new('M1-M3-M4') }

    it 'returns the correct keys' do
      expect(key.all_keys).to eq ['M1', 'M3', 'M4', 'M1-M3', 'M1-M4', 'M3-M4', 'M1-M3-M4']
    end
  end

  describe '#ids' do
    subject(:key) { Key.new('M1-M3-M4') }

    it 'returns the correct ids' do
      expect(key.ids).to eq [1, 3, 4]
    end
  end
end
