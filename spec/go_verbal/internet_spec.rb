require 'spec_helper'
require 'go_verbal/nav_menu_mapper'

module GoVerbal
  RSpec.describe Internet do
    describe "#give_me" do
      it "makes a request to the NetHTTP wrapper with given host and port" do
        net_http_library = NetHTTPWrapper.new
        internet = Internet.new(net_http_library)

        url = "https://www.google.com/images"

        expect(net_http_library).
        to receive(:start).
        with("www.google.com",
          443,
          :use_ssl => true
          )

        internet.give_me(url)
      end

      it "makes an HTTP request using wrapper's get method with a kind of Nokogiri::HTML" do
        url = "https://www.google.com/images"
        http = double
        get_request = double

        net_http_library = instance_double(NetHTTPWrapper, get: get_request)
        allow(net_http_library).to receive(:start).and_yield(http)

        internet = Internet.new(net_http_library)
        allow(internet).to receive(:extract_data)

        expect(http).to receive(:request).with(get_request)

        internet.give_me(url)
      end

      it "returns an HTMLDoc" do
        url = "https://www.google.com/images"
        http = double
        allow(http).to receive(:request)
        get_request = double

        net_http_library = instance_double(NetHTTPWrapper, get: get_request)
        allow(net_http_library).to receive(:start).and_yield(http)

        internet = Internet.new(net_http_library)
        allow(internet).to receive(:extract_data)

        returned_thing = internet.give_me(url)
        expect(returned_thing).to be_a_kind_of(HTMLDoc)
      end
    end

    describe "extract_data" do
      it "gets body from response" do
        response_body = double
        response = double(body: response_body)
        internet = Internet.new

        expect(Nokogiri).to receive(:HTML).with(response_body)

        internet.extract_data(response)
      end
    end
  end
end
