require 'rails_helper'

module Filmplanner
  RSpec.describe Selection do
    describe '#theaters' do
      let(:date) { Time.zone.local(2018, 7, 7) }

      let!(:theater1) { FactoryBot.create(:theater) }
      let!(:theater2) { FactoryBot.create(:theater) }
      let!(:theater3) { FactoryBot.create(:theater) }

      subject(:selection) { Selection.new(date, [theater1.id, theater2.id], []) }

      it 'returns the correct theaters' do
        expect(selection.theaters).to match_array([theater1, theater2])
      end
    end

    describe '#shows' do
      let(:date1) { Time.zone.local(2018, 7, 7) }
      let(:date2) { Time.zone.local(2018, 7, 8) }

      let!(:theater1) { FactoryBot.create(:theater) }
      let!(:theater2) { FactoryBot.create(:theater) }

      let!(:movie1) { FactoryBot.create(:movie) }
      let!(:movie2) { FactoryBot.create(:movie) }

      let!(:show1) { FactoryBot.create(:show, theater: theater1, movie: movie1, date: date1) }
      let!(:show2) { FactoryBot.create(:show, theater: theater1, movie: movie2, date: date1) }
      let!(:show3) { FactoryBot.create(:show, theater: theater1, date: date2) }
      let!(:show4) { FactoryBot.create(:show, theater: theater2, date: date1) }

      subject(:selection) { Selection.new(date1, [theater1.id], [movie1.id, movie2.id]) }

      it 'returns the correct shows' do
        expect(selection.shows).to match_array([show1, show2])
      end
    end

    describe '#movies' do
      let(:date1) { Time.zone.local(2018, 7, 7) }
      let(:date2) { Time.zone.local(2018, 7, 8) }

      let!(:theater1) { FactoryBot.create(:theater) }
      let!(:theater2) { FactoryBot.create(:theater) }

      let!(:movie1) { FactoryBot.create(:movie) }
      let!(:movie2) { FactoryBot.create(:movie) }

      let!(:show1) { FactoryBot.create(:show, theater: theater1, movie: movie1, date: date1) }
      let!(:show2) { FactoryBot.create(:show, theater: theater1, movie: movie2, date: date1) }
      let!(:show3) { FactoryBot.create(:show, theater: theater1, date: date2) }
      let!(:show4) { FactoryBot.create(:show, theater: theater2, date: date1) }

      subject(:selection) { Selection.new(date1, [theater1.id], [movie1.id, movie2.id]) }

      it 'returns the correct shows' do
        expect(selection.movies).to match_array([movie1, movie2])
      end
    end
  end
end
