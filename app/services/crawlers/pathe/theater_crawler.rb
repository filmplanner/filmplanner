module Crawlers
  module Pathe
    class TheaterCrawler < ApplicationCrawler
      def path
        @options[:path]
      end

      def crawl
        {
          id:     page.find('.visual-movie__toggle-favorite.in-favorites', 'data-cinema'),
          name:   page.find('.visual-cinema__location', 'data-name'),
          city:   page.find('.visual-cinema__location', 'data-city'),
          image:  page.find('.visual-fullpage__slide img', 'src'),
          url:    path
        }
      end

      before :crawl, call: :timeout
    end
  end
end
