require 'rails_helper'

module Crawlers
  module Pathe
    RSpec.describe TheaterCrawler do
      describe '#crawl' do
        subject(:crawler) { TheaterCrawler.new(path: '/bioscoop/amersfoort') }

        it 'returns the correct hash' do
          VCR.use_cassette 'crawlers/pathe/theater_response' do
            expect(crawler.crawl).to eq(
              external_id: '23',
              name: 'Pathé Amersfoort',
              city: 'Amersfoort',
              image: 'https://media.pathe.nl/gfx_content/bioscoop/wallpaper/pathe.nl_1600x590px_amersfoort.jpg',
              url: '/bioscoop/amersfoort'
            )
          end
        end
      end
    end
  end
end
