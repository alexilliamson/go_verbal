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

        expect{ site.go_to("url")}.to change{site.current_page_menu}
      end
    end

    describe "#menu_links" do
      context "when current page is not set" do
        it "fails with message" do
          site = GPOSiteBrowser.new
          invalid_class = "dodo bird"

          expect{site.menu_links(invalid_class)}.to raise_error("CURRENT PAGE_MENU NOT SET")
        end
      end

      context "when current page is set" do
        it "fails with message" do
          site = GPOSiteBrowser.new
          site.current_page_menu = double("Menu", div: [])

          invalid_class = "dodo bird"
          error_expectation = "NO MENU LINKS {#css_class: #{invalid_class}}"
          expect{site.menu_links(invalid_class)}.to raise_error(error_expectation)
        end
      end
    end
  end
end
