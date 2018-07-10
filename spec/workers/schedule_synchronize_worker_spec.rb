require 'rails_helper'

RSpec.describe ScheduleSynchronizeWorker do
  describe '#perform' do
    let!(:theater) { FactoryBot.create(:theater, name: 'Pathé Buitenhof') }

    subject(:worker) { ScheduleSynchronizeWorker.new }

    it 'creates the correct records' do
      expect(Crawlers::Pathe::ScheduleCrawler).to receive(:crawl).at_least(:once) do
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

      expect { worker.perform }.to change { Movie.count }.and change { Show.count }
    end
  end
end
