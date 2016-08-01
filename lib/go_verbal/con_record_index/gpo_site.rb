module GoVerbal
  class GPOSite
    def get_page(url: )
      uri = convert_to_uri(url)

      Net::HTTP.start(uri.host, uri.port)
    end

    def convert_to_uri(url)
      URI(url)
    end
  end
end
