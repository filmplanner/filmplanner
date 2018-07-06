require 'rails_helper'

module Parsers
  RSpec.describe ShowParser do
    describe '#klass' do
      subject(:parser) { ShowParser.new({}) }

      it 'returns the correct class' do
        expect(parser.klass).to eq Show
      end
    end

    describe '#start_at' do
      let(:hash) do
        {
          date:     Date.new(2018, 7, 7),
          start_at: '12:30',
          end_at:   '14:45'
        }
      end

      subject(:parser) { ShowParser.new(hash) }

      it 'returns the correct datetime' do
        expect(parser.start_at).to eq Time.zone.local(2018, 7, 7, 12, 30, 0)
      end

      context 'when show starts at nighttime' do
        let(:hash) do
          {
            date: Date.new(2018, 7, 7),
            start_at: '02:30'
          }
        end

        it 'returns the correct datetime' do
          expect(parser.start_at).to eq Time.zone.local(2018, 7, 8, 2, 30, 0)
        end
      end
    end

    describe '#end_at' do
      let(:hash) do
        {
          date:     Date.new(2018, 7, 7),
          start_at: '12:30',
          end_at:   '16:30'
        }
      end

      subject(:parser) { ShowParser.new(hash) }

      it 'returns the correct datetime' do
        expect(parser.end_at).to eq Time.zone.local(2018, 7, 7, 16, 30, 0)
      end

      context 'when show ends at nighttime' do
        let(:hash) do
          {
            date:     Date.new(2018, 7, 7),
            start_at: '23:30',
            end_at:   '00:45'
          }
        end

        it 'returns the correct datetime' do
          expect(parser.end_at).to eq Time.zone.local(2018, 7, 8, 0, 45, 0)
        end
      end
    end

    describe '#parse' do
      let(:hash) do
        {
          date:     Date.new(2018, 5, 5),
          start_at: '12:30',
          end_at:   '16:30',
          version:  'IMAX 3D',
          url:      '/tickets/start/123'
        }
      end
      let(:movie) { FactoryBot.create(:movie) }
      let(:theater) { FactoryBot.create(:theater) }

      subject(:parser) { ShowParser.new(hash, movie: movie, theater: theater) }

      fit 'creates a new record' do
        expect { parser.parse }.to change { Show.count }.from(0).to(1)

        show = Show.first
        expect(show.date).to eq Date.new(2018, 5, 5)
        expect(show.start_at).to eq Time.zone.local(2018, 5, 5, 12, 30, 0)
        expect(show.end_at).to eq Time.zone.local(2018, 5, 5, 16, 30, 0)
        expect(show.version).to eq 'IMAX 3D'
        expect(show.url).to eq '/tickets/start/123'
      end

      context 'when record already exists' do
        let!(:show) do
          FactoryBot.create(
            :show,
            movie:    movie,
            theater:  theater,
            date:     Date.new(2018, 5, 5),
            start_at: Time.zone.local(2018, 5, 5, 12, 30, 0),
            end_at:   Time.zone.local(2018, 5, 5, 16, 30, 0),
            version:  'IMAX',
            url:      '/tickets/start/321'
          )
        end

        it 'updates the record' do
          expect { parser.parse }.to_not change { Show.count }

          show = Show.first
          expect(show.date).to eq Date.new(2018, 5, 5)
          expect(show.start_at).to eq Time.zone.local(2018, 5, 5, 12, 30, 0)
          expect(show.end_at).to eq Time.zone.local(2018, 5, 5, 16, 30, 0)
          expect(show.version).to eq 'IMAX 3D'
          expect(show.url).to eq '/tickets/start/123'
        end
      end
    end
  end
end
