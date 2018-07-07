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
        start_at: Time.zone.local(2018, 7, 7, 12, 30, 0),
        end_at: Time.zone.local(2018, 7, 7, 14, 20, 0)
      )
    end

    it 'creates the correct record' do
      expect { Suggestion.for_shows([show1, show2]) }.to change { Suggestion.count }.from(0).to(1)

      suggestion = Suggestion.first
      expect(suggestion.key).to eq 'S666M234T3-S999M456T3'
      expect(suggestion.show_key).to eq 'S666-S999'
      expect(suggestion.movie_key).to eq 'M234-M456'
      expect(suggestion.theater_key).to eq 'T3'
      expect(suggestion.date).to eq Time.zone.local(2018, 7, 7)
      expect(suggestion.start_at).to eq Time.zone.local(2018, 7, 7, 10, 0, 0)
      expect(suggestion.end_at).to eq Time.zone.local(2018, 7, 7, 14, 20, 0)
      expect(suggestion.wait_time).to eq 15
      expect(suggestion.shows_amount).to eq 2
      expect(suggestion.theaters_amount).to eq 1
    end

    context 'when record already exists' do
      let!(:suggestion) { FactoryBot.create(:suggestion, key: 'S666M234T3-S999M456T3') }

      it 'updates the existing record' do
        expect { Suggestion.for_shows([show1, show2]) }.not_to change { Suggestion.count }

        suggestion = Suggestion.first
        expect(suggestion.key).to eq 'S666M234T3-S999M456T3'
        expect(suggestion.show_key).to eq 'S666-S999'
        expect(suggestion.movie_key).to eq 'M234-M456'
        expect(suggestion.theater_key).to eq 'T3'
        expect(suggestion.date).to eq Time.zone.local(2018, 7, 7)
        expect(suggestion.start_at).to eq Time.zone.local(2018, 7, 7, 10, 0, 0)
        expect(suggestion.end_at).to eq Time.zone.local(2018, 7, 7, 14, 20, 0)
        expect(suggestion.wait_time).to eq 15
        expect(suggestion.shows_amount).to eq 2
        expect(suggestion.theaters_amount).to eq 1
      end
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

    let!(:suggestion) { Suggestion.for_shows([show1, show2]) }

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

    let!(:suggestion) { Suggestion.for_shows([show1, show2]) }

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

    let!(:suggestion) { Suggestion.for_shows([show1, show2]) }

    it 'returns the correct shows' do
      expect(suggestion.shows).to match_array([show1, show2])
    end
  end
end
