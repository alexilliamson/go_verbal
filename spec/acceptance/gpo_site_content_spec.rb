require 'spec_helper'
require 'go_verbal'

module GoVerbal
  RSpec.describe "GPOSite Content" do
    describe "#xpath_query", :vcr do
      context "after #go_to_root is called" do
        it "has year elements with onclick attributes containing fdsys" do
          site = GPOSiteBrowser.new
          year_selector = "div[@class='level1 browse-level']/a"
          site.go_to_root

          link = site.xpath_query(year_selector).first
          onclick = link.attributes["onclick"].to_s
          expect(onclick).to include("fdsys")
        end
      end
    end

    context "after #go_to is called with a year's url", :vcr do
      it "has month-level xpath_query" do
        month_selector =  "div[@class='level2 browse-level']/a"

        site = GPOSiteBrowser.new
        year_url = valid_year_url

        site.go_to(year_url)
        link_texts = site.xpath_query(month_selector).map(&:text)

        expect(1..12).to cover(link_texts.size)
      end

      it "has a January link" do
        month_selector = "div[@class='level2 browse-level']/a"

        site = GPOSiteBrowser.new
        year_url = valid_year_url

        site.go_to(year_url)
        link_texts = site.xpath_query(month_selector).map(&:text)

        expect(link_texts.first).to include("January")
      end
    end

    context "on a date page" do
      it "has four section URLs", :vcr do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        site.go_to(date_url)

        section_css_class = "div[@class='level4 browse-leaf-level ']/a"
        links = site.xpath_query(section_css_class)

        expect(links.size).to eq(4)
      end

      it "includes an element with a 4th sibling with Daily Digest as text", :vcr do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        site.go_to(date_url)

        section_css_class = "div[@class='level4 browse-leaf-level ']/a"
        link = site.xpath_query(section_css_class).first.parent.children[4]#.children[1].text

        expect(link.text).to match("Daily Digest")
      end
    end

    context "on a section page", :vcr do
      it "has a table rows with class 'browse-download-links' that havelinks" do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
        site.go_to(date_url)

        css_query = "td[@class='browse-download-links']/a"
        links = site.xpath_query(css_query)

        expect(links).to_not be_empty
      end

      it "has a table rows with class 'browse-download-links' whose links contain text text" do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
        site.go_to(date_url)

        css_query = "td[@class='browse-download-links']/a"
        links = site.xpath_query(css_query)
        text_page_links = links.select{|l| l.text =~ /text/i}

        expect(text_page_links).to_not be_empty
      end

      it "has a table rows with class 'browse-download-links' whose links contain htm hrefs" do
        site = GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
        site.go_to(date_url)

        css_query = "table[@class='browse-node-table']//td[@class='browse-download-links']/a"
        links = site.xpath_query(css_query)

        # links = links.select{|l| l.text =~ /text/i}

        text_page_links = links.map do |l|
          l.attributes['href']
        end


        expect(text_page_links).to_not be_empty
      end
    end


    def valid_year_url
      "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
    end
  end
end
