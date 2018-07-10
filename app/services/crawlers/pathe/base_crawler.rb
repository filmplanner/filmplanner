module Crawlers
  module Pathe
    class BaseCrawler < ApplicationCrawler
      def base_url
        'https://www.pathe.nl'
      end
    end
  end
end
