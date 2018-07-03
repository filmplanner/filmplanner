module Crawler
  module BaseCrawler
    attr_reader :path

    def initialize(path = '/')
      @path = path
    end

    private

    def request
      HTTParty.get(ENV.fetch('CRAWLER_BASE_URL') + path)
    end

    def document
      @document ||= Nokogiri::HTML(request)
    end

    def css(selector)
      document.css(selector)
    end

    def find(selector, attribute = nil)
      selection = css(selector)

      if attribute.present?
        selection.first.attributes[attribute].text
      else
        selection.first.text
      end
    end
  end
end
