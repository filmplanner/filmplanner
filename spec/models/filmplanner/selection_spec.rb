require 'rails_helper'

module Filmplanner
  RSpec.describe Selection do
    describe '#theaters' do
      let(:date) { Time.zone.local(2018, 7, 7) }

      let!(:theater1) { FactoryBot.create(:theater) }
      let!(:theater2) { FactoryBot.create(:theater) }
      let!(:theater3) { FactoryBot.create(:theater) }

      subject(:selection) { Selection.new(date, [theater1.id, theater2.id]) }

      it 'returns the correct theaters' do
        expect(selection.theaters).to match_array([theater1, theater2])
      end
    end

    describe '#shows' do
      let(:date1) { Time.zone.local(2018, 7, 7) }
      let(:date2) { Time.zone.local(2018, 7, 8) }

      let!(:theater1) { FactoryBot.create(:theater) }
      let!(:theater2) { FactoryBot.create(:theater) }

      let!(:show1) { FactoryBot.create(:show, theater: theater1, date: date1) }
      let!(:show2) { FactoryBot.create(:show, theater: theater1, date: date1) }
      let!(:show3) { FactoryBot.create(:show, theater: theater1, date: date2) }
      let!(:show4) { FactoryBot.create(:show, theater: theater2, date: date1) }

      subject(:selection) { Selection.new(date1, [theater1.id]) }

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

      subject(:selection) { Selection.new(date1, [theater1.id]) }

      it 'returns the correct shows' do
        expect(selection.movies).to match_array([movie1, movie2])
      end
    end

    describe '#suggestions' do
      let(:date1) { Time.zone.local(2018, 7, 7) }
      let(:date2) { Time.zone.local(2018, 7, 8) }

      let!(:theater1) { FactoryBot.create(:theater) }
      let!(:theater2) { FactoryBot.create(:theater) }

      let!(:suggestion1) { FactoryBot.create(:suggestion, date: date1, theater_key: theater1.to_key) }
      let!(:suggestion2) { FactoryBot.create(:suggestion, date: date1, theater_key: theater1.to_key) }
      let!(:suggestion3) { FactoryBot.create(:suggestion, date: date1, theater_key: theater2.to_key) }
      let!(:suggestion4) { FactoryBot.create(:suggestion, date: date2, theater_key: theater1.to_key) }
      let!(:suggestion5) { FactoryBot.create(:suggestion, date: date1, theater_key: SuggestionKey.from_keys([theater1, theater2].map(&:to_key))) }

      subject(:selection) { Selection.new(date1, [theater1.id]) }

      it 'returns the correct suggestions' do
        expect(selection.suggestions).to match_array([suggestion1, suggestion2])
      end

      context 'with multiple theaters' do
        subject(:selection) { Selection.new(date1, [theater1.id, theater2.id]) }

        it 'returns the correct suggestions' do
          expect(selection.suggestions).to match_array([suggestion1, suggestion2, suggestion3, suggestion5])
        end
      end
    end
  end
end
