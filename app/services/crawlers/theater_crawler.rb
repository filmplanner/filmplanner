module Crawlers
  class TheaterCrawler < ApplicationCrawler
    def crawl
      {
        id:     find('.visual-movie__toggle-favorite.in-favorites', 'data-cinema'),
        name:   find('.visual-cinema__location', 'data-name'),
        city:   find('.visual-cinema__location', 'data-city'),
        image:  find('.visual-fullpage__slide img', 'src'),
        path:   @path
      }
    end
  end
end
