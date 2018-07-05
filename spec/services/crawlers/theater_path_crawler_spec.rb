require 'rails_helper'

module Crawlers
  RSpec.describe TheaterPathCrawler do
    describe '#crawl' do
      subject(:crawler) { TheaterPathCrawler.new }

      it 'returns the correct hash' do
        VCR.use_cassette 'crawlers/theater_path_response' do
          expect(crawler.crawl).to include(
            paths: include(
              '/bioscoop/amersfoort',
              '/bioscoop/spuimarkt',
              '/bioscoop/buitenhof',
              '/bioscoop/scheveningen'
            )
          )
        end
      end
    end
  end
end
