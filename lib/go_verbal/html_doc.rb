module GoVerbal
  class HTMLDoc
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def div(options)
      id = options[:id]
      matcher = selector_string(:div, id: id)

      content.css(matcher)
    end

    def selector_string(selector, options = {})
      id = options[:id]
      selector_string = selector.to_s
      id_string = id.to_s

      selector_string + "#" + id_string
    end
  end
end
