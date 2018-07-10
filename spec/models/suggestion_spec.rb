require 'rails_helper'

RSpec.describe Suggestion do
  describe '.for_shows' do
    let(:movie1) { FactoryBot.create(:movie, id: 234) }
    let(:movie2) { FactoryBot.create(:movie, id: 456) }
    let(:theater1) { FactoryBot.create(:theater, id: 3) }

    let(:show1) do
      FactoryBot.create(
        :show,
        id: 666,
        movie: movie1,
        theater: theater1,
        date: Time.zone.local(2018, 7, 7),
        start_at: Time.zone.local(2018, 7, 7, 10, 0, 0),
        end_at: Time.zone.local(2018, 7, 7, 12, 15, 0)
      )
    end
    let(:show2) do
      FactoryBot.create(
        :show,
        id: 999,
        movie: movie2,
        theater: theater1,
        date: Time.zone.local(2018, 7, 7),
        start_at: Time.zone.local(2018, 7, 7, 12, 30, 0),
        end_at: Time.zone.local(2018, 7, 7, 14, 20, 0)
      )
    end

    it 'creates the correct hash' do
      expect(Suggestion.for_shows([show1, show2])).to eq(
        key:              'S666M234T3-S999M456T3',
        show_key:         'S666-S999',
        movie_key:        'M234-M456',
        theater_key:      'T3',
        date:             Time.zone.local(2018, 7, 7),
        start_at:         Time.zone.local(2018, 7, 7, 10, 0, 0),
        end_at:           Time.zone.local(2018, 7, 7, 14, 20, 0),
        wait_time:        15 * 60,
        shows_amount:     2,
        theaters_amount:  1
      )
    end
  end

  describe '#theaters' do
    let(:movie1) { FactoryBot.create(:movie) }
    let(:movie2) { FactoryBot.create(:movie) }

    let!(:theater1) { FactoryBot.create(:theater) }
    let!(:theater2) { FactoryBot.create(:theater) }
    let!(:theater3) { FactoryBot.create(:theater) }

    let!(:show1) { FactoryBot.create(:show, movie: movie1, theater: theater1) }
    let!(:show2) { FactoryBot.create(:show, movie: movie2, theater: theater2) }

    let!(:suggestion) {  Suggestion.create(Suggestion.for_shows([show1, show2])) }

    it 'returns the correct theaters' do
      expect(suggestion.theaters).to match_array([theater1, theater2])
    end
  end

  describe '#movies' do
    let(:movie1) { FactoryBot.create(:movie) }
    let(:movie2) { FactoryBot.create(:movie) }
    let(:movie3) { FactoryBot.create(:movie) }

    let!(:theater1) { FactoryBot.create(:theater) }
    let!(:theater2) { FactoryBot.create(:theater) }

    let!(:show1) { FactoryBot.create(:show, movie: movie1, theater: theater1) }
    let!(:show2) { FactoryBot.create(:show, movie: movie2, theater: theater2) }

    let!(:suggestion) { Suggestion.create(Suggestion.for_shows([show1, show2])) }

    it 'returns the correct movies' do
      expect(suggestion.movies).to match_array([movie1, movie2])
    end
  end

  describe '#shows' do
    let(:movie1) { FactoryBot.create(:movie) }
    let(:movie2) { FactoryBot.create(:movie) }

    let!(:theater1) { FactoryBot.create(:theater) }
    let!(:theater2) { FactoryBot.create(:theater) }

    let!(:show1) { FactoryBot.create(:show, movie: movie1, theater: theater1) }
    let!(:show2) { FactoryBot.create(:show, movie: movie2, theater: theater2) }
    let!(:show3) { FactoryBot.create(:show, movie: movie2, theater: theater2) }

    let!(:suggestion) {  Suggestion.create(Suggestion.for_shows([show1, show2])) }

    it 'returns the correct shows' do
      expect(suggestion.shows).to match_array([show1, show2])
    end
  end
end
