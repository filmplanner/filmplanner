module Crawlers
  class ApplicationCrawler
    CRAWL_TIMEOUT = 3

    class << self
      def before(method, options)
        old_method = instance_method(method)
        define_method(method) do
          send(options[:call])
          old_method.bind(self).call
        end
      end

      def crawl(options = {})
        new(options).crawl
      end
    end

    def initialize(options = {})
      @options = options
    end

    def base_url
      raise NotImplementedError
    end

    def path
      raise NotImplementedError
    end

    def crawl
      raise NotImplementedError
    end

    private

    def timeout
      sleep(CRAWL_TIMEOUT) unless Rails.env.test?
    end

    def request
      HTTParty.get(base_url + path)
    end

    def page
      @page ||= ResponseQuerier.for_response(request)
    end
  end
end
