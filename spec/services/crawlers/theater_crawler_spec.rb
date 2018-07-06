require 'rails_helper'

module Crawlers
  RSpec.describe TheaterCrawler do
    describe '#crawl' do
      subject(:crawler) { TheaterCrawler.new(path: '/bioscoop/amersfoort') }

      it 'returns the correct hash' do
        VCR.use_cassette 'crawlers/theater_response' do
          expect(crawler.crawl).to eq(
            id: '23',
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
