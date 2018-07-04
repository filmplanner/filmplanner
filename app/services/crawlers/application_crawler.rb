module Crawlers
  class ApplicationCrawler
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
      elements = css(selector)

      if attribute.present?
        elements.first.attributes[attribute].text
      else
        elements.first.text
      end
    end

    def find_all(selector, attribute = nil)
      elements = css(selector)

      if attribute.present?
        elements.map do |element|
          element.attributes[attribute].text
        end
      else
        elements.map(&:text)
      end
    end
  end
end
