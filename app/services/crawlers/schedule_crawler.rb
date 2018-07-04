module Crawlers
  class ScheduleCrawler < ApplicationCrawler
    def crawl
      {

      }
    end

    before :crawl, call: :timeout
  end
end
