require 'rails_helper'

module Crawlers
  RSpec.describe ScheduleCrawler do
    describe '#crawl' do
      let(:theater_ids) { [1, 7, 13] }
      let(:date) { Date.new(2018, 7, 7) }
      subject(:crawler) { ScheduleCrawler.new(theater_ids: theater_ids, date: date) }

      it 'returns the correct hash' do
        VCR.use_cassette 'crawlers/schedule_response' do
          expect(crawler.crawl).to include(
            movies: include(
              a_hash_including(
                id:           '21381',
                title:        'Jurassic World: Fallen Kingdom',
                description:  'Welkom in Jurassic World: Fallen Kingdom! Favoriete personages keren terug in dit 3D actie-spektakel.',
                image:        'https://media.pathe.nl/nocropthumb/180x254/gfx_content/posterhr/Jurassic-World_-Fallen-Kingdom_ps_1.jpg',
                url:          '/film/21381/jurassic-world-fallen-kingdom',
                theaters: include(
                  a_hash_including(
                    name: 'Pathé City',
                    shows: include(
                      a_hash_including(
                        date:     date,
                        start_at: '16:30',
                        end_at:   '18:53',
                        version:  '3D',
                        url:      '/tickets/start/2635645'
                      )
                    )
                  )
                )
              )
            )
          )
        end
      end
    end
  end
end
