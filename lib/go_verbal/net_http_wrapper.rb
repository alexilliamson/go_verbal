module GoVerbal
  class NetHTTPWrapper
    def initialize
      @library = Net::HTTP
    end

    def start(host, port, options={  })
      @library.start(host, port, options) do |yielded_thing|
        yield yielded_thing
      end
    end

    def get(request)
      @library::Get.new(request)
    end
  end
end
