module GoVerbal
  class NokogiriHTMLDocWrapper
    attr_accessor :content, :string_content

    def initialize(content)
      @content = Nokogiri::HTML(content)
      @string_content = content.to_s
    end

    def css(css_query)
      content.css(css_query)
    end

    def length
      string_content.size
    end
  end
end
