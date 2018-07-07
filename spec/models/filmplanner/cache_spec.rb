require 'rails_helper'

module Filmplanner
  RSpec.describe Cache do
    let(:date) { Time.zone.local(2018, 7, 7) }

    let(:theater1) { FactoryBot.create(:theater) }
    let(:theater2) { FactoryBot.create(:theater) }

    let!(:movie1) { FactoryBot.create(:movie) }
    let!(:movie2) { FactoryBot.create(:movie) }
    let!(:movie3) { FactoryBot.create(:movie) }

    let!(:show1) { FactoryBot.create(:show, theater: theater1, movie: movie1, date: Time.zone.local(2018, 7, 7)) }
    let!(:show2) { FactoryBot.create(:show, theater: theater1, movie: movie2, date: Time.zone.local(2018, 7, 7)) }
    let!(:show3) { FactoryBot.create(:show, theater: theater1, movie: movie2, date: Time.zone.local(2018, 7, 7)) }
    let!(:show4) { FactoryBot.create(:show, theater: theater1, movie: movie2, date: Time.zone.local(2018, 7, 8)) }
    let!(:show5) { FactoryBot.create(:show, theater: theater2, movie: movie2, date: Time.zone.local(2018, 7, 7)) }
    let!(:show6) { FactoryBot.create(:show, theater: theater2, movie: movie3, date: Time.zone.local(2018, 7, 7)) }

    subject(:cache) { Cache.new(date, [theater1.id]) }

    describe '#shows' do
      it 'returns the correct records' do
        expect(cache.shows).to match_array([show1, show2, show3])
      end

      context 'with multiple theaters' do
        subject(:cache) { Cache.new(date, [theater1.id, theater2.id]) }

        it 'returns the correct records' do
          expect(cache.shows).to match_array([show1, show2, show3, show5, show6])
        end
      end
    end

    describe '#movie_ids' do
      it 'returns the correct ids' do
        expect(cache.movie_ids).to match_array([movie1.id, movie2.id])
      end

      context 'with multiple theaters' do
        subject(:cache) { Cache.new(date, [theater1.id, theater2.id]) }

        it 'returns the correct ids' do
          expect(cache.movie_ids).to match_array([movie1.id, movie2.id, movie3.id])
        end
      end
    end

    describe '#shows_by_movie' do
      it 'returns the correct hash' do
        expect(cache.shows_by_movie).to a_hash_including(
          movie1.id => [show1],
          movie2.id => [show2, show3]
        )
      end

      context 'with multiple theaters' do
        subject(:cache) { Cache.new(date, [theater1.id, theater2.id]) }

        it 'returns the correct hash' do
          expect(cache.shows_by_movie).to a_hash_including(
            movie1.id => [show1],
            movie2.id => [show2, show3, show5],
            movie3.id => [show6]
          )
        end
      end
    end

    describe '#shows_by_movie' do
      it 'returns the correct shows' do
        expect(cache.shows_by_movies(movie1.id)).to match_array(
          [[show1]]
        )
      end

      context 'with multiple movies' do
        it 'returns the correct shows' do
          expect(cache.shows_by_movies([movie1.id, movie2.id])).to match_array(
            [[show1], [show2, show3]]
          )
        end
      end
    end
  end
end
