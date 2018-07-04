module Crawlers
  class ResponseQuerier
    def initialize(response)
      @html = Nokogiri::HTML(response)
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

    private

    def css(selector)
      @html.css(selector)
    end
  end
end
