require 'spec_helper'
require 'go_verbal/con_record_index/gpo_site'

module GoVerbal
  RSpec.describe GPOSite do
    describe "#get_page" do
      it "starts a request using the NetHTTP library" do
        site = GPOSite.new
        valid_url = get_valid_url

        expect(net_http_library).to receive(:start)
          .with("www.google.com", 443)

        site.get_page(url: valid_url)
      end

    end

    describe "#convert_to_uri" do
      context "given a valid_url" do
        it "parses host" do
          site = GPOSite.new
          valid_url = get_valid_url

          uri = site.convert_to_uri(valid_url)

          expect(uri.host).to eq("www.google.com")
        end
      end
    end

    describe "#go_to_root" do
      it "sends :root to NavMenuMapper with html" do
        site = GPOSite.new

        expect(NavMenuMapper).to receive(:root).with(a_kind_of(HTMLDoc))

        root = site.go_to_root
      end

      it "sets a new nav_menu" do
        site = GPOSite.new
        site.go_to_root

        expect(site.nav_menu).to be_a_kind_of(NavMenu)
      end
    end

    def get_valid_url
      "https://www.google.com/images"
    end

    def net_http_library
      Net::HTTP
    end
  end
end
