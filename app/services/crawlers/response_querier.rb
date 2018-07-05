module Crawlers
  class ResponseQuerier
    class << self
      def for_response(response)
        new(Nokogiri::HTML(response))
      end

      def for_element(element)
        new(element)
      end
    end

    def initialize(html)
      @html = html
    end

    def to_s
      text(@html)
    end

    def css(selector)
      elements = @html.css(selector)

      elements.map do |element|
        ResponseQuerier.for_element(element)
      end
    end

    def find(selector, attribute = nil)
      elements = @html.css(selector)

      if attribute.present?
        text(elements.first.attributes[attribute])
      else
        text(elements.first)
      end
    end

    def find_all(selector, attribute = nil)
      elements = @html.css(selector)

      if attribute.present?
        elements.map do |element|
          text(element.attributes[attribute])
        end
      else
        elements.map { text(element) }
      end
    end

    def attribute(attribute)
      text(@html.attributes[attribute])
    end

    private

    def text(element = nil)
      element&.text&.strip
    end
  end
end
