require 'rails_helper'

module Parsers
  module Pathe
    RSpec.describe ScheduleParser do
      describe '#parse' do
        let(:hash) do
          {
            movies: [
              {
                id:           '21381',
                title:        'Jurassic World: Fallen Kingdom',
                description:  'Welkom in Jurassic World: Fallen Kingdom! Favoriete personages keren terug in dit 3D actie-spektakel.',
                image:        'https://media.pathe.nl/nocropthumb/180x254/gfx_content/posterhr/Jurassic-World_-Fallen-Kingdom_ps_1.jpg',
                url:          '/film/21381/jurassic-world-fallen-kingdom',
                theaters: [
                  name: 'Pathé Buitenhof',
                  shows: [
                    {
                      date:     Date.new(2018, 7, 7),
                      start_at: '16:30',
                      end_at:   '18:53',
                      version:  '3D',
                      url:      '/tickets/start/2635645'
                    },
                    {
                      date:     Date.new(2018, 7, 7),
                      start_at: '18:30',
                      end_at:   '20:53',
                      version:  '3D',
                      url:      '/tickets/start/2635645'
                    }
                  ]
                ]
              }
            ]
          }
        end
        let!(:theater) { FactoryBot.create(:theater, name: 'Pathé Buitenhof') }

        subject(:parser) { ScheduleParser.new(hash) }

        it 'creates the correct records' do
          expect { parser.parse }.to change { Movie.count }.from(0).to(1).and \
            change { Show.count }.from(0).to(2)
        end
      end
    end
  end
end
