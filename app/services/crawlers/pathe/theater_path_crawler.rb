module Crawlers
  module Pathe
    class TheaterPathCrawler < BaseCrawler
      def path
        '/'
      end

      def crawl
        {
          paths: page.find_all('.nav-primary__item--has-sub:nth-child(2) li a', 'href')
        }
      end

      before :crawl, call: :timeout
    end
  end
end
