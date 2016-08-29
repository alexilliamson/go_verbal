require 'spec_helper'
require 'go_verbal/gpo_site_browser'

module GoVerbal
  RSpec.describe GPOSiteBrowser do
    describe "#go_to" do
    end

    describe "#menu_links", :vcr do
      context "when current page menu is nil" do
        it "returns an empty array" do
          site = described_class.new
          site.current_page = double(:menu => nil)
          result = site.menu_links(nil)
          expect(result).to eq([])
        end
      end


      context "after #go_to_root is called" do
        it "is present" do
          site = described_class.new
          site.go_to_root

          expect(site.current_page).to have_content
        end


        context "given year_css_class = level1 browse-level" do
          it "returns elements with onclick attributes containing URLs" do
            site = described_class.new
            site.go_to_root

            link = site.menu_links("level1 browse-level").first
            expect(link.attributes["onclick"].to_s).to include("fdsys")
          end
        end
      end
    end

    describe "#go_to" do
      it "sets current_page" do
        internet = instance_double(Internet, give_me: nil)
        site = described_class.new
        site.internet = internet

        site.go_to("url")

        expect(site.current_page).to_not be_nil
      end

      context "with year_url" do
        it "demands its content from the internet" do
          internet = instance_double(Internet)
          site = described_class.new
          site.internet = internet
          expect(internet).to receive(:give_me).with(year_url)


          site.go_to(year_url)
        end

        def year_url
          "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
        end
      end
    end
  end
end
