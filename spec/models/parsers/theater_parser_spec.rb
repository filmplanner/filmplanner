require 'rails_helper'

module Parsers
  RSpec.describe TheaterParser do
    describe '#klass' do
      subject(:parser) { TheaterParser.new({}) }

      it 'returns the correct class' do
        expect(parser.klass).to eq Theater
      end
    end

    describe '#parse' do
      let(:hash) do
        {
          id: '23',
          name: 'Pathé Amersfoort',
          city: 'Amersfoort',
          image: 'https://media.pathe.nl/gfx_content/bioscoop/wallpaper/pathe.nl_1600x590px_amersfoort.jpg',
          url: '/bioscoop/amersfoort'
        }
      end
      subject(:parser) { TheaterParser.new(hash) }

      it 'creates a new record' do
        expect { parser.parse }.to change { Theater.count }.from(0).to(1)

        theater = Theater.first
        expect(theater.id).to eq 23
        expect(theater.name).to eq 'Pathé Amersfoort'
        expect(theater.city).to eq 'Amersfoort'
        expect(theater.image).to eq 'https://media.pathe.nl/gfx_content/bioscoop/wallpaper/pathe.nl_1600x590px_amersfoort.jpg'
        expect(theater.url).to eq '/bioscoop/amersfoort'
      end

      context 'when record already exists' do
        let!(:theater) { FactoryBot.create(:theater, id: 23, name: 'troofsremA') }

        it 'updates the record' do
          expect { parser.parse }.to_not change { Theater.count }

          theater = Theater.first
          expect(theater.id).to eq 23
          expect(theater.name).to eq 'Pathé Amersfoort'
          expect(theater.city).to eq 'Amersfoort'
          expect(theater.image).to eq 'https://media.pathe.nl/gfx_content/bioscoop/wallpaper/pathe.nl_1600x590px_amersfoort.jpg'
          expect(theater.url).to eq '/bioscoop/amersfoort'
        end
      end
    end
  end
end
