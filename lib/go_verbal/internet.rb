require_relative 'html_doc'
require_relative 'net_http_wrapper'
require_relative 'nokogiri_html_doc_wrapper'

module GoVerbal
  class Internet
    def initialize(net_library = NetHTTPWrapper.new)
      @net_library = net_library
    end

    def give_me(url)
      library = @net_library
      uri = URI(url)

      host = uri.host
      port = uri.port

      library.start(host, port,:use_ssl=>true) do |http|
        request = library.get(uri)
        response = http.request(request)
        content = extract_data(response)

        return HTMLDoc.new(content)
      end
    end

    def extract_data(response)
      body = response.body
      nokogiri = NokogiriHTMLDocWrapper.new(body)
    end
  end
end
