module GoVerbal
  class HTMLDoc
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def div(options)
      css_class = options[:css_class]
      matcher = class_selector_string(:div, css_class)

      content.css(matcher)
    end

    def has_content?
      content.length > 0
    end

    def class_selector_string(selector, css_class)
      selector_string = selector.to_s
      class_string = css_class.to_s

      selector_string + "[@class='" + class_string + "']"
    end
  end
end
