module Crawler
  class Theater
    include BaseCrawler

    def crawl
      {
        id:     find('.visual-movie__toggle-favorite.in-favorites', 'data-cinema'),
        name:   find('.visual-cinema__location', 'data-name'),
        city:   find('.visual-cinema__location', 'data-city'),
        image:  find('.visual-fullpage__slide img', 'src')
      }
    end
  end
end
