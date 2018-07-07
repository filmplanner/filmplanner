require 'rails_helper'

RSpec.describe Theater do
  it { should have_many(:shows) }

  describe '.key_for' do
    it 'returns the correct key' do
      expect(Theater.key_for(1)).to eq 'T1'
    end
  end

  describe '#to_key' do
    subject(:theater) { FactoryBot.create(:theater, id: 3) }

    it 'returns the correct key' do
      expect(theater.to_key).to eq 'T3'
    end
  end
end
