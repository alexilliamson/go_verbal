require_relative 'net_http_wrapper'
require_relative 'nokogiri_html_doc_wrapper'

module GoVerbal
  class Internet
    attr_reader :net_library

    def initialize(net_library = NetHTTPWrapper.new)
      @net_library = net_library
    end

    def give_me(url)
      uri = URI(url)

      host = uri.host
      port = uri.port
      request = get_request(uri)

      begin
        retries ||= 0
        make_request(request, host, port)
      rescue => e
        if (retries += 1) < 5
          sleep_time = 60 * (retries)
          puts("#{e} occured; waiting sleeping for #{sleep_time} seconds")
          sleep(sleep_time)
          retry
        else
          puts(Time.now)
          raise e
        end
      end
    end

    def get_request(uri)
      net_library.get(uri)
    end

    def make_request(request, host, port)
      net_library.start(host, port,:use_ssl=>true) do |http|
        response = http.request(request)
        content = extract_data(response)

        return response.body#HTMLMenu.new(content)
      end
    end

    def extract_data(response)
      body = response.body
      nokogiri = NokogiriHTMLDocWrapper.new(body)
    end
  end
end
