require_relative 'html_doc'
require_relative 'net_http_wrapper'

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
        extract_data(response)
      end
    end

    def extract_data(response)
      body = response.body
      nokogiri = Nokogiri::HTML(body)

      OpenStruct.new(html: HTMLDoc.new(nokogiri))
    end
  end
end
