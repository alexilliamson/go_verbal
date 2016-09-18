require 'spec_helper'
require 'go_verbal'

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
        link_texts = site.menu_links(month_css_class).map(&:text)

        expect(1..12).to cover(link_texts.size)
      end

      it "has a January link" do
        month_css_class = "level2 browse-level"

        site = GPOSiteBrowser.new
        year_url = valid_year_url

        site.go_to(year_url)
        link_texts = site.menu_links(month_css_class).map(&:text)

        expect(link_texts.first).to include("January")
      end
    end

    context "on a date page" do
      it "has four section URLs", :vcr do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        site.go_to(date_url)

        section_css_class = GoVerbal.css_classes[:section]
        links = site.menu_links(section_css_class)

        expect(links.size).to eq(4)
      end

      it "includes an element with a 4th sibling with Daily Digest as text", :vcr do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        site.go_to(date_url)

        section_css_class = GoVerbal.css_classes[:section]
        link = site.menu_links(section_css_class).first.parent.children[4]#.children[1].text

        expect(link.text).to match("Daily Digest")
      end
    end

    def valid_year_url
      "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
    end
  end
end
