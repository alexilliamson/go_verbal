require 'spec_helper'
# require 'go_verbal/nav_menu_mapper'

module GoVerbal
  RSpec.describe NetHTTPWrapper do
    describe "#start", :vcr do
      context "given the GPOSite root page URL" do
        it "yields an object that can be turned into a Nokogiri::HTML doc" do
          url = ROOT_URL
          wrapper = NetHTTPWrapper.new
          nokogiri_creation_block = lambda do |url|
            uri = URI(url)
            wrapper.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
              request = wrapper.get(uri)
              response = http.request request
              html = response.body
              Nokogiri::HTML(response.body)
            end
          end

          expect{ nokogiri_creation_block.call(url) }.to_not raise_error
        end
      end
    end
  end
end
