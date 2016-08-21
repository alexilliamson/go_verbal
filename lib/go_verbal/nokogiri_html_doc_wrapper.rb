module GoVerbal
  class NokogiriHTMLDocWrapper
    attr_accessor :content

    def initialize(content)
      @content = Nokogiri::HTML(content)
    end

    def css(css_query)
      content.css(css_query)
    end
  end
end
