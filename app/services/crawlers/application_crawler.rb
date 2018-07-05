module Crawlers
  class ApplicationCrawler
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

    def crawl
      raise NotImplementedError
    end

    def path
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
      @page ||= ResponseQuerier.for_response(request)
    end
  end
end
