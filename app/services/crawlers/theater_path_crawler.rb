module Crawlers
  class TheaterPathCrawler < ApplicationCrawler
    def crawl
      find_all('.nav-primary__item--has-sub:nth-child(2) li a', 'href')
    end
  end
end
