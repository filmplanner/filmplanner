require 'rails_helper'

module Parsers
  module Pathe
    RSpec.describe MovieParser do
      describe '#klass' do
        subject(:parser) { MovieParser.new({}) }

        it 'returns the correct class' do
          expect(parser.klass).to eq Movie
        end
      end

      describe '#parse' do
        let(:hash) do
          {
            id: '21381',
            title: 'Jurassic World: Fallen Kingdom',
            description: 'Welkom in Jurassic World: Fallen Kingdom! Favoriete personages keren terug in dit 3D actie-spektakel.',
            image: 'https://media.pathe.nl/thumb/180x254/gfx_content/posterhr/Jurassic-World_-Fallen-Kingdom_ps_1.jpg',
            url: 'film/21381/jurassic-world-fallen-kingdom'
          }
        end
        subject(:parser) { MovieParser.new(hash) }

        it 'creates a new record' do
          expect { parser.parse }.to change { Movie.count }.from(0).to(1)

          movie = Movie.first
          expect(movie.id).to eq 21381
          expect(movie.title).to eq 'Jurassic World: Fallen Kingdom'
          expect(movie.description).to eq 'Welkom in Jurassic World: Fallen Kingdom! Favoriete personages keren terug in dit 3D actie-spektakel.'
          expect(movie.image).to eq 'https://media.pathe.nl/thumb/180x254/gfx_content/posterhr/Jurassic-World_-Fallen-Kingdom_ps_1.jpg'
          expect(movie.url).to eq 'film/21381/jurassic-world-fallen-kingdom'
        end

        context 'when record already exists' do
          let!(:movie) { FactoryBot.create(:movie, id: 21381, title: 'Jurassic World') }

          it 'updates the record' do
            expect { parser.parse }.to_not change { Movie.count }

            movie = Movie.first
            expect(movie.id).to eq 21381
            expect(movie.title).to eq 'Jurassic World: Fallen Kingdom'
            expect(movie.description).to eq 'Welkom in Jurassic World: Fallen Kingdom! Favoriete personages keren terug in dit 3D actie-spektakel.'
            expect(movie.image).to eq 'https://media.pathe.nl/thumb/180x254/gfx_content/posterhr/Jurassic-World_-Fallen-Kingdom_ps_1.jpg'
            expect(movie.url).to eq 'film/21381/jurassic-world-fallen-kingdom'
          end
        end
      end
    end
  end
end
