require 'spec_helper'
require 'go_verbal/internet'

module GoVerbal
  RSpec.describe Internet do
    describe "#give_me" do
      it "makes a request to the NetHTTP wrapper with given host and port" do
        net_http_library = NetHTTPWrapper.new
        internet = Internet.new(net_http_library)

        url = "https://www.google.com/images"

        expect(net_http_library).to receive(:start).with(
          "www.google.com",
          443,
          :use_ssl => true
          )

        internet.give_me(url)
      end

      it "makes an HTTP request using wrapper's get method with a kind of Nokogiri::HTML" do
        url = "https://www.google.com/images"
        http = mock_http
        net = mock_net
        allow(net).to receive(:start).and_yield(http)

        internet = Internet.new(net)

        expect(http).to receive(:request)

        internet.give_me(url)
      end

      it "returns a NokogiriHTMLDocWrapper" do
        url = "https://www.google.com/images"
        http = mock_http
        net = mock_net
        allow(net).to receive(:start).and_yield(http)

        internet = Internet.new(net)

        returned_thing = internet.give_me(url)

        expect(returned_thing).to be_a_kind_of(String)
      end

      def mock_http
        response = double(body: "")
        http = double(request: response)
      end

      def mock_net
        get_request = double

        instance_double(NetHTTPWrapper, get: get_request)
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
