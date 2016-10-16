module GoVerbal
  class NokogiriHTMLDocWrapper
    attr_accessor :content

    def initialize(content)
      @content = Nokogiri::HTML(content)
    end

    def css(css_query)
      begin
        content.css(css_query)
      rescue
        raise "#{css_query} is invalid"
      end
    end
  end
end
