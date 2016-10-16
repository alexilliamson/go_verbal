require 'spec_helper'
require 'go_verbal'
module GoVerbal
  RSpec.describe GoVerbal do
    describe ".scrape_mapping" do
      subject{GoVerbal.scrape_mapping}

      it "has year" do
        query = subject.get_css_query(:year)

        expect( query )
          .to eq("div[@class='level1 browse-level']/a")
      end

      it "has month" do
        query = subject.get_css_query(:month)

        expect( query )
          .to eq("div[@class='level2 browse-level']/a")
      end

      it "has day" do
        query = subject.get_css_query(:date)

        expect( query )
          .to eq("div[@class='level3 browse-level']/a")
      end

      it "has section" do
        query = subject.get_css_query(:section)

        expect( query )
          .to eq("div[@class='level4 browse-leaf-level ']/a")
      end

      it "has text_page" do
        query = subject.get_css_query(:text_page)

        expect( query )
          .to eq("table[@class='browse-node-table']//td[@class='browse-download-links']/a")
      end
    end
  end
end
