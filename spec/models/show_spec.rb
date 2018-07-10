require 'rails_helper'

RSpec.describe Show do
  it { should belong_to(:movie) }
  it { should belong_to(:theater) }

  describe '.key_for' do
    it 'returns the correct key' do
      expect(Show.key_for(1)).to eq 'S1'
    end
  end

  describe '.wait_time' do
    let(:show1) do
      FactoryBot.create(
        :show,
        start_at: Time.zone.local(2018, 7, 7, 10, 0, 0),
        end_at: Time.zone.local(2018, 7, 7, 12, 15, 0)
      )
    end
    let(:show2) do
      FactoryBot.create(
        :show,
        start_at: Time.zone.local(2018, 7, 7, 12, 30, 0),
        end_at: Time.zone.local(2018, 7, 7, 14, 20, 0)
      )
    end
    let(:show3) do
      FactoryBot.create(
        :show,
        start_at: Time.zone.local(2018, 7, 7, 14, 29, 0),
        end_at: Time.zone.local(2018, 7, 7, 16, 15, 0)
      )
    end

    it 'calculates the time between shows' do
      expect(Show.wait_time([show1, show2, show3])).to eq((15 + 9) * 60)
    end

    context 'when only one show' do
      it 'returns zero' do
        expect(Show.wait_time([show1])).to eq 0
      end
    end
  end

  describe '.attainable?' do
    let(:show1) do
      FactoryBot.create(
        :show,
        start_at: Time.zone.local(2018, 7, 7, 10, 0, 0),
        end_at: Time.zone.local(2018, 7, 7, 12, 15, 0)
      )
    end
    let(:show2) do
      FactoryBot.create(
        :show,
        start_at: Time.zone.local(2018, 7, 7, 12, 30, 0),
        end_at: Time.zone.local(2018, 7, 7, 14, 20, 0)
      )
    end
    let(:show3) do
      FactoryBot.create(
        :show,
        start_at: Time.zone.local(2018, 7, 7, 14, 29, 0),
        end_at: Time.zone.local(2018, 7, 7, 16, 15, 0)
      )
    end

    it { expect(Show.attainable?([show1, show2, show3])).to eq true }

    context 'when show ends during next show' do
      before do
        show2.start_at = Time.zone.local(2018, 7, 7, 12, 14, 0)
      end

      it { expect(Show.attainable?([show1, show2, show3])).to eq false }
    end
  end

  describe '#to_key' do
    subject(:show) { FactoryBot.create(:show, id: 35) }

    it 'returns the correct key' do
      expect(show.to_key).to eq 'S35'
    end
  end

  describe '#theater_key' do
    let(:theater) { FactoryBot.create(:theater, id: 3) }

    subject(:show) { FactoryBot.create(:show, theater: theater) }

    it 'returns the correct key' do
      expect(show.theater_key).to eq 'T3'
    end
  end

  describe '#movie_key' do
    let(:movie) { FactoryBot.create(:movie, id: 3) }

    subject(:show) { FactoryBot.create(:show, movie: movie) }

    it 'returns the correct key' do
      expect(show.movie_key).to eq 'M3'
    end
  end

  describe '#full_key' do
    let(:movie) { FactoryBot.create(:movie, id: 3) }
    let(:theater) { FactoryBot.create(:theater, id: 1) }

    subject(:show) { FactoryBot.create(:show, id: 4, movie: movie, theater: theater) }

    it 'returns the correct key' do
      expect(show.full_key).to eq 'S4M3T1'
    end
  end

  describe '#wait_time' do
    let(:next_show) { FactoryBot.create(:show, start_at: Time.zone.local(2018, 7, 7, 12, 0, 0)) }

    subject(:show) { FactoryBot.create(:show, end_at: Time.zone.local(2018, 7, 7, 11, 59, 0)) }

    it 'calculates time between shows' do
      expect(show.wait_time(next_show)).to eq 60
    end
  end

  describe '#ends_before?' do
    let(:next_show) { FactoryBot.create(:show, start_at: Time.zone.local(2018, 7, 7, 12, 0, 0)) }

    subject(:show) { FactoryBot.create(:show, end_at: Time.zone.local(2018, 7, 7, 11, 59, 0)) }

    it { expect(show.ends_before?(next_show)).to eq true }

    context 'when show ends during next show' do
      subject(:show) { FactoryBot.create(:show, end_at: Time.zone.local(2018, 7, 7, 12, 30, 0)) }

      it { expect(show.ends_before?(next_show)).to eq false }
    end
  end
end
