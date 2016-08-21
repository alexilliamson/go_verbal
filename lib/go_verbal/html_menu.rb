require_relative "nokogiri_html_doc_wrapper"
module GoVerbal
  class HTMLMenu
    attr_reader :content

    def initialize(content)
      @content = NokogiriHTMLDocWrapper.new(content)
    end

    def menu(div_classes)
      menu_links = []

      div_classes.each do |div_class|
        div_matches = div(div_class)
        menu_links.concat(div_matches)
      end

      menu_links
    end

    def div(css_class)
      matcher = class_selector_string(:div, css_class)

      content.css(matcher)
    end

    def has_content?
      content_string = content.to_s
      content_string.length > 0
    end

    def class_selector_string(selector, css_class)
      selector_string = selector.to_s
      class_string = css_class.to_s

      selector_string + "[@class='" + class_string + "']"
    end
  end
end
