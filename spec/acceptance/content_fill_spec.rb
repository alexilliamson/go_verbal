require 'spec_helper'
require 'go_verbal'

RSpec.describe "updating page content" do
  context "when content does not exist" do
    before(:each) do
      pages_table = DB[:pages]

      page_attributes = {
        url: 'https://www.gpo.gov/fdsys/pkg/CREC-1994-01-25/html/CREC-1994-01-25-pt1-PgD.htm',
        title: "140 Cong. Rec. D - Daily Digest/Highlights + Senate",
        date: Date.parse("1994-01-25"),
        section: "Daily Digest"
      }

      pages_table.insert(page_attributes)
    end

    it "gets html body at page url", :vcr do
      browser = GoVerbal::GPOSiteBrowser.new
      page = DB[:pages].first

      id = page[:id]
      url = page[:url]

      html = browser.go_to(url)
      content = html.body

      DB[:pages].where(:id => id).update(content: content)

      page = DB[:pages].where(:id => id).first

      expect(page[:content]).to include("FIRST SESSION OF THE ONE HUNDRED THIRD CONGRESS")
    end
  end
end
