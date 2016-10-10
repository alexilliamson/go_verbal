require 'spec_helper'
require 'go_verbal/gpo_site_browser'

module GoVerbal
  RSpec.describe GPOSiteBrowser do
    describe "#go_to" do
      it "demands content from the internet" do
        internet = instance_double(Internet)

        site = described_class.new
        site.internet = internet

        year_url = double

        expect(internet).to receive(:give_me).with(year_url)

        site.go_to(year_url)
      end

      it "changes current_page_menu" do
        internet = instance_double(Internet, give_me: nil)
        site = described_class.new
        site.internet = internet

        expect{  site.go_to("url") }.to change{ site.current_page }
      end
    end

    describe "#xpath_query" do
      context "when current page is not set" do
        it "fails with message" do
          site = GPOSiteBrowser.new
          invalid_class = "dodo bird"

          expect{ site.xpath_query(invalid_class) }.to raise_error("CURRENT PAGE NOT SET")
        end
      end
    end
  end
end
