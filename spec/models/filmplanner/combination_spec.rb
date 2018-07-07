require 'rails_helper'

module Filmplanner
  RSpec.describe Combination do
    let(:date) { Time.zone.local(2018, 7, 7) }

    let(:theater) { FactoryBot.create(:theater) }

    let!(:movie1) { FactoryBot.create(:movie) }
    let!(:show1M1) { FactoryBot.create(:show, theater: theater, movie: movie1, date: Time.zone.local(2018, 7, 7)) }
    let!(:show2M1) { FactoryBot.create(:show, theater: theater, movie: movie1, date: Time.zone.local(2018, 7, 7)) }

    let!(:movie2) { FactoryBot.create(:movie) }
    let!(:show1M2) { FactoryBot.create(:show, theater: theater, movie: movie2, date: Time.zone.local(2018, 7, 7)) }
    let!(:show2M2) { FactoryBot.create(:show, theater: theater, movie: movie2, date: Time.zone.local(2018, 7, 7)) }
    let!(:show3M2) { FactoryBot.create(:show, theater: theater, movie: movie2, date: Time.zone.local(2018, 7, 7)) }

    let!(:movie3) { FactoryBot.create(:movie) }
    let!(:show1M3) { FactoryBot.create(:show, theater: theater, movie: movie3, date: Time.zone.local(2018, 7, 7)) }
    let!(:show2M3) { FactoryBot.create(:show, theater: theater, movie: movie3, date: Time.zone.local(2018, 7, 7)) }
    let!(:show3M3) { FactoryBot.create(:show, theater: theater, movie: movie3, date: Time.zone.local(2018, 7, 7)) }

    let!(:movie4) { FactoryBot.create(:movie) }
    let!(:show1M4) { FactoryBot.create(:show, theater: theater, movie: movie4, date: Time.zone.local(2018, 7, 7)) }

    let!(:movie5) { FactoryBot.create(:movie) }
    let!(:show1M5) { FactoryBot.create(:show, theater: theater, movie: movie5, date: Time.zone.local(2018, 7, 7)) }
    let!(:show2M5) { FactoryBot.create(:show, theater: theater, movie: movie5, date: Time.zone.local(2018, 7, 7)) }

    let!(:movie6) { FactoryBot.create(:movie) }
    let!(:show1M6) { FactoryBot.create(:show, theater: theater, movie: movie6, date: Time.zone.local(2018, 7, 7)) }
    let!(:show2M6) { FactoryBot.create(:show, theater: theater, movie: movie6, date: Time.zone.local(2018, 7, 7)) }
    let!(:show3M6) { FactoryBot.create(:show, theater: theater, movie: movie6, date: Time.zone.local(2018, 7, 7)) }

    subject(:combination) { Combination.new(date, [theater.id]) }

    describe '#movie_combinations' do
      it 'returns the correct combinations' do
        expect(combination.movie_combinations).to match_array([
          [movie1.id, movie2.id],
          [movie1.id, movie3.id],
          [movie1.id, movie4.id],
          [movie1.id, movie5.id],
          [movie1.id, movie6.id],
          [movie2.id, movie3.id],
          [movie2.id, movie4.id],
          [movie2.id, movie5.id],
          [movie2.id, movie6.id],
          [movie3.id, movie4.id],
          [movie3.id, movie5.id],
          [movie3.id, movie6.id],
          [movie4.id, movie5.id],
          [movie4.id, movie6.id],
          [movie5.id, movie6.id],
          [movie1.id, movie2.id, movie3.id],
          [movie1.id, movie2.id, movie4.id],
          [movie1.id, movie2.id, movie5.id],
          [movie1.id, movie2.id, movie6.id],
          [movie1.id, movie3.id, movie4.id],
          [movie1.id, movie3.id, movie5.id],
          [movie1.id, movie3.id, movie6.id],
          [movie1.id, movie4.id, movie5.id],
          [movie1.id, movie4.id, movie6.id],
          [movie1.id, movie5.id, movie6.id],
          [movie2.id, movie3.id, movie4.id],
          [movie2.id, movie3.id, movie5.id],
          [movie2.id, movie3.id, movie6.id],
          [movie2.id, movie4.id, movie5.id],
          [movie2.id, movie4.id, movie6.id],
          [movie2.id, movie5.id, movie6.id],
          [movie3.id, movie4.id, movie5.id],
          [movie3.id, movie4.id, movie6.id],
          [movie3.id, movie5.id, movie6.id],
          [movie4.id, movie5.id, movie6.id],
          [movie1.id, movie2.id, movie3.id, movie4.id],
          [movie1.id, movie2.id, movie3.id, movie5.id],
          [movie1.id, movie2.id, movie3.id, movie6.id],
          [movie1.id, movie2.id, movie4.id, movie5.id],
          [movie1.id, movie2.id, movie4.id, movie6.id],
          [movie1.id, movie2.id, movie5.id, movie6.id],
          [movie1.id, movie3.id, movie4.id, movie5.id],
          [movie1.id, movie3.id, movie4.id, movie6.id],
          [movie1.id, movie3.id, movie5.id, movie6.id],
          [movie1.id, movie4.id, movie5.id, movie6.id],
          [movie2.id, movie3.id, movie4.id, movie5.id],
          [movie2.id, movie3.id, movie4.id, movie6.id],
          [movie2.id, movie3.id, movie5.id, movie6.id],
          [movie2.id, movie4.id, movie5.id, movie6.id],
          [movie3.id, movie4.id, movie5.id, movie6.id],
          [movie1.id, movie2.id, movie3.id, movie4.id, movie5.id],
          [movie1.id, movie2.id, movie3.id, movie4.id, movie6.id],
          [movie1.id, movie2.id, movie3.id, movie5.id, movie6.id],
          [movie1.id, movie2.id, movie4.id, movie5.id, movie6.id],
          [movie1.id, movie3.id, movie4.id, movie5.id, movie6.id],
          [movie2.id, movie3.id, movie4.id, movie5.id, movie6.id]
        ])
      end
    end

    describe '#show_combinations' do
      context 'with two movies' do
        it 'returns the cartesian product of movie shows' do
          expect(combination.show_combinations([movie1.id, movie2.id])).to match_array([
            [show1M1, show1M2],
            [show1M1, show2M2],
            [show1M1, show3M2],

            [show2M1, show1M2],
            [show2M1, show2M2],
            [show2M1, show3M2]
          ])
        end
      end

      context 'with three movies' do
        it 'returns the cartesian product of movie shows' do
          expect(combination.show_combinations([movie1.id, movie2.id, movie3.id])).to match_array([
            [show1M1, show1M2, show1M3],
            [show1M1, show1M2, show2M3],
            [show1M1, show1M2, show3M3],

            [show1M1, show2M2, show1M3],
            [show1M1, show2M2, show2M3],
            [show1M1, show2M2, show3M3],

            [show1M1, show3M2, show1M3],
            [show1M1, show3M2, show2M3],
            [show1M1, show3M2, show3M3],

            [show2M1, show1M2, show1M3],
            [show2M1, show1M2, show2M3],
            [show2M1, show1M2, show3M3],

            [show2M1, show2M2, show1M3],
            [show2M1, show2M2, show2M3],
            [show2M1, show2M2, show3M3],

            [show2M1, show3M2, show1M3],
            [show2M1, show3M2, show2M3],
            [show2M1, show3M2, show3M3]
          ])
        end
      end

      context 'with four movies' do
        it 'returns the cartesian product of movie shows' do
          expect(combination.show_combinations([movie1.id, movie2.id, movie3.id, movie4.id])).to match_array([
            [show1M1, show1M2, show1M3, show1M4],
            [show1M1, show1M2, show2M3, show1M4],
            [show1M1, show1M2, show3M3, show1M4],

            [show1M1, show2M2, show1M3, show1M4],
            [show1M1, show2M2, show2M3, show1M4],
            [show1M1, show2M2, show3M3, show1M4],

            [show1M1, show3M2, show1M3, show1M4],
            [show1M1, show3M2, show2M3, show1M4],
            [show1M1, show3M2, show3M3, show1M4],

            [show2M1, show1M2, show1M3, show1M4],
            [show2M1, show1M2, show2M3, show1M4],
            [show2M1, show1M2, show3M3, show1M4],

            [show2M1, show2M2, show1M3, show1M4],
            [show2M1, show2M2, show2M3, show1M4],
            [show2M1, show2M2, show3M3, show1M4],

            [show2M1, show3M2, show1M3, show1M4],
            [show2M1, show3M2, show2M3, show1M4],
            [show2M1, show3M2, show3M3, show1M4]
          ])
        end
      end

      context 'with five movies' do
        it 'returns the cartesian product of movie shows' do
          expect(combination.show_combinations([movie1.id, movie2.id, movie3.id, movie4.id, movie5.id])).to match_array([
            [show1M1, show1M2, show1M3, show1M4, show1M5],
            [show1M1, show1M2, show2M3, show1M4, show1M5],
            [show1M1, show1M2, show3M3, show1M4, show1M5],

            [show1M1, show2M2, show1M3, show1M4, show1M5],
            [show1M1, show2M2, show2M3, show1M4, show1M5],
            [show1M1, show2M2, show3M3, show1M4, show1M5],

            [show1M1, show3M2, show1M3, show1M4, show1M5],
            [show1M1, show3M2, show2M3, show1M4, show1M5],
            [show1M1, show3M2, show3M3, show1M4, show1M5],

            [show2M1, show1M2, show1M3, show1M4, show1M5],
            [show2M1, show1M2, show2M3, show1M4, show1M5],
            [show2M1, show1M2, show3M3, show1M4, show1M5],

            [show2M1, show2M2, show1M3, show1M4, show1M5],
            [show2M1, show2M2, show2M3, show1M4, show1M5],
            [show2M1, show2M2, show3M3, show1M4, show1M5],

            [show2M1, show3M2, show1M3, show1M4, show1M5],
            [show2M1, show3M2, show2M3, show1M4, show1M5],
            [show2M1, show3M2, show3M3, show1M4, show1M5],

            [show1M1, show1M2, show1M3, show1M4, show2M5],
            [show1M1, show1M2, show2M3, show1M4, show2M5],
            [show1M1, show1M2, show3M3, show1M4, show2M5],

            [show1M1, show2M2, show1M3, show1M4, show2M5],
            [show1M1, show2M2, show2M3, show1M4, show2M5],
            [show1M1, show2M2, show3M3, show1M4, show2M5],

            [show1M1, show3M2, show1M3, show1M4, show2M5],
            [show1M1, show3M2, show2M3, show1M4, show2M5],
            [show1M1, show3M2, show3M3, show1M4, show2M5],

            [show2M1, show1M2, show1M3, show1M4, show2M5],
            [show2M1, show1M2, show2M3, show1M4, show2M5],
            [show2M1, show1M2, show3M3, show1M4, show2M5],

            [show2M1, show2M2, show1M3, show1M4, show2M5],
            [show2M1, show2M2, show2M3, show1M4, show2M5],
            [show2M1, show2M2, show3M3, show1M4, show2M5],

            [show2M1, show3M2, show1M3, show1M4, show2M5],
            [show2M1, show3M2, show2M3, show1M4, show2M5],
            [show2M1, show3M2, show3M3, show1M4, show2M5]
          ])
        end
      end
    end

    describe '#combine' do
      context 'with 5 attainable shows' do
        before do
          show1M1.update(start_at: Time.zone.local(2018, 7, 7, 10, 0, 0), end_at: Time.zone.local(2018, 7, 7, 12, 0, 0))
          show1M2.update(start_at: Time.zone.local(2018, 7, 7, 12, 5, 0), end_at: Time.zone.local(2018, 7, 7, 14, 0, 0))
          show1M3.update(start_at: Time.zone.local(2018, 7, 7, 14, 10, 0), end_at: Time.zone.local(2018, 7, 7, 16, 30, 0))
          show1M4.update(start_at: Time.zone.local(2018, 7, 7, 16, 40, 0), end_at: Time.zone.local(2018, 7, 7, 18, 30, 0))
          show1M5.update(start_at: Time.zone.local(2018, 7, 7, 19, 0, 0), end_at: Time.zone.local(2018, 7, 7, 22, 0, 0))
        end

        it 'creates the correct suggestions' do
          expect { combination.combine }.to change { Suggestion.count }.from(0).to(10)
          expect(Suggestion.all.map(&:key)).to include(
            SuggestionKey.join([show1M1, show1M2].map(&:full_key)),
            SuggestionKey.join([show1M2, show1M3].map(&:full_key)),
            SuggestionKey.join([show1M3, show1M4].map(&:full_key)),
            SuggestionKey.join([show1M4, show1M5].map(&:full_key)),
            SuggestionKey.join([show1M1, show1M2, show1M3].map(&:full_key)),
            SuggestionKey.join([show1M2, show1M3, show1M4].map(&:full_key)),
            SuggestionKey.join([show1M3, show1M4, show1M5].map(&:full_key)),
            SuggestionKey.join([show1M1, show1M2, show1M3, show1M4].map(&:full_key)),
            SuggestionKey.join([show1M2, show1M3, show1M4, show1M5].map(&:full_key)),
            SuggestionKey.join([show1M1, show1M2, show1M3, show1M4, show1M5].map(&:full_key))
          )
        end
      end
    end
  end
end
