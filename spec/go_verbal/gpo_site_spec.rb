require 'spec_helper'
require 'go_verbal/gpo_site'

module GoVerbal
  RSpec.describe GPOSite do
    describe "#menu_links", :vcr do
      context "after #go_to_root is called" do
        it "is present" do
          site = GPOSite.new
          site.go_to_root

          expect(site.current_page).to have_content
        end


        context "given year_css_class = level1 browse-level" do
          it "returns elements with onclick attributes containing URLs" do
            site = GPOSite.new
            site.go_to_root

            link = site.menu_links("level1 browse-level").first
            expect(link.attributes["onclick"].to_s).to include("fdsys")
          end
        end
      end
    end
  end
end
