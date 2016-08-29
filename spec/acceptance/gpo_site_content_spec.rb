require 'spec_helper'
require 'go_verbal/gpo_site_browser'

module GoVerbal
  RSpec.describe "GPOSite Content" do
    context "after #go_to is called with a year's url", :vcr do
      it "has month-level menu_links" do
        month_css_class = "level2 browse-level"

        site = GPOSiteBrowser.new
        year_url = valid_year_url

        site.go_to(year_url)
        links = site.menu_links(month_css_class)

        # expect(Browser).to receive(:go_to).with valid_year_url
        expect(1..12).to cover(links.size)
      end

  end

    def valid_year_url
      "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
    end

  end
end
