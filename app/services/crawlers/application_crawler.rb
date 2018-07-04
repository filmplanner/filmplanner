module Crawlers
  class ApplicationCrawler
    extend Concerns::Timeoutable

    attr_reader :path

    def self.crawl(path = '/')
      new(path).crawl
    end

    def initialize(path = '/')
      @path = path
    end

    def crawl
      raise NotImplementedError
    end

    private

    def timeout
      timout = ENV.fetch('CRAWLER_TIMEOUT').to_i

      sleep(timout) unless Rails.env.test?
    end

    def request
      base_url = ENV.fetch('CRAWLER_BASE_URL')

      HTTParty.get(base_url + path)
    end

    def page
      @page ||= ResponseQuerier.new(request)
    end
  end
end
