module Crawlers
  class TheaterPathCrawler < ApplicationCrawler
    def crawl
      page.find_all('.nav-primary__item--has-sub:nth-child(2) li a', 'href')
    end

    before :crawl, call: :timeout
  end
end
