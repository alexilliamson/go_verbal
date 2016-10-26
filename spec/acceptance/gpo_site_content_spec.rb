require 'spec_helper'
require 'go_verbal'


RSpec.describe "GPOSite Content" do
  context "on the root page", :vcr do
    subject do
      site = GoVerbal::GPOSiteBrowser.new
      site.go_to_root
      site
    end

    it "has link tags with parent div class 'level1 browse-level'" do
      xpath = "div[@class='level1 browse-level']/a"
      links = subject.xpath_query(xpath)

      expect(links).to_not be_empty
    end

    describe "link tags with parent div class 'level1 browse-level'" do
      it "has onclick containing 'fdsys'" do
        xpath = "div[@class='level1 browse-level']/a"

        link = subject.xpath_query(xpath).first
        onclick = link.attributes["onclick"].to_s
        expect(onclick).to include("fdsys")
      end
    end
  end


    context "on year pages", :vcr do
      it "has link tags with parent div class 'level1 browse-level'" do
        xpath =  "div[@class='level2 browse-level']/a"

        site = GoVerbal::GPOSiteBrowser.new
        year_url = valid_year_url

        site.go_to(year_url)
        link_texts = site.xpath_query(xpath).map(&:text)

        expect(1..12).to cover(link_texts.size)
      end

      describe "has link tags with parent div class 'level1 browse-level'" do
        it "has a January link" do
          month_selector = "div[@class='level2 browse-level']/a"

          site = GoVerbal::GPOSiteBrowser.new
          year_url = valid_year_url

          site.go_to(year_url)
          link_texts = site.xpath_query(month_selector).map(&:text)

          expect(link_texts.first).to include("January")
        end
      end
    end

    context "on date pages" do
      it "has 4 link tags with parent div class 'level4 browse-level'", :vcr do
        site = GoVerbal::GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        site.go_to(date_url)

        section_css_class = "div[@class='level4 browse-leaf-level ']/a"
        links = site.xpath_query(section_css_class)

        expect(links.size).to eq(4)
      end

      it "includes an element with a 4th sibling with Daily Digest as text", :vcr do
        site = GoVerbal::GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?browsePath=1994/01/01-25%5C/3&collectionCode=CREC&isCollapsed=false&leafLevelBrowse=false'
        site.go_to(date_url)

        section_css_class = "div[@class='level4 browse-leaf-level ']/a"
        link = site.xpath_query(section_css_class).first.parent.children[4]#.children[1].text

        expect(link.text).to match("Daily Digest")
      end
    end

    context "on a section page", :vcr do
      it "has a table rows with class 'browse-download-links' that havelinks" do
        site = GoVerbal::GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
        site.go_to(date_url)

        css_query = "td[@class='browse-download-links']/a"
        links = site.xpath_query(css_query)

        expect(links).to_not be_empty
      end

      it "has a table rows with class 'browse-download-links' whose links contain text text" do
        site = GoVerbal::GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
        site.go_to(date_url)

        css_query = "td[@class='browse-download-links']/a"
        links = site.xpath_query(css_query)
        text_page_links = links.select{ |l| l.text =~ /text/i }

        expect(text_page_links).to_not be_empty
      end

      it "has a table rows with class 'browse-download-links' whose links contain htm hrefs" do
        site = GoVerbal::GPOSiteBrowser.new
        date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
        site.go_to(date_url)

        css_query = "table[@class='browse-node-table']//td[@class='browse-download-links']/a"
        links = site.xpath_query(css_query)

        # links = links.select{ |l| l.text =~ /text/i }

        text_page_links = links.map do |l|
          l.attributes['href']
        end


        expect(text_page_links).to_not be_empty
      end

      describe "table rows with class 'browse-download-links' whose links contain htm hrefs" do
        it "has great uncle with title text siblings blah we'll see" do
          site = GoVerbal::GPOSiteBrowser.new
          date_url = 'https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=1994%2F01%2F01-25%5C%2F3%2FDAILYDIGEST&isCollapsed=false&leafLevelBrowse=false&isDocumentResults=true&ycord=614'
          site.go_to(date_url)

          css_query = "table[@class='browse-node-table']//td[@class='browse-download-links']/a"
          links = site.xpath_query(css_query)

          # puts(links.first.methods)
          great_uncle_text = links.first.parent.parent.previous_element.children[1].text.to_s

          expect(great_uncle_text).to include('140 Cong. Rec. D - Daily Digest/Highlights + Senate')
        end
      end
    end


    def valid_year_url
      "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
    end
  end
