require 'spec_helper'
require 'go_verbal/gpo_site_browser'

module GoVerbal
  RSpec.describe "GPOSite Content" do
    describe "#menu_links", :vcr do
      context "after #go_to_root is called" do
        it "has year elements with onclick attributes containing fdsys" do
          site = GPOSiteBrowser.new
          year_css_class = "level1 browse-level"
          site.go_to_root

          link = site.menu_links(year_css_class).first
          onclick = link.attributes["onclick"].to_s
          expect(onclick).to include("fdsys")
        end
      end
    end

    context "after #go_to is called with a year's url", :vcr do
      it "has month-level menu_links" do
        month_css_class = "level2 browse-level"

        site = GPOSiteBrowser.new
        year_url = valid_year_url

        site.go_to(year_url)
        links = site.menu_links(month_css_class)

        expect(1..12).to cover(links.size)
      end
    end

    def valid_year_url
      "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
    end
  end
end
