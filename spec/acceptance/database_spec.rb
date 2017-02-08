require 'spec_helper'
require 'go_verbal'

RSpec.describe "the database" do
  it "can store a page of congressional record text in the pages table" do
    DB = Sequel.sqlite('test.db')
    pages_table = DB[:pages]

    page_attributes = {
      url: 'https://www.gpo.gov/fdsys/pkg/CREC-1994-01-25/html/CREC-1994-01-25-pt1-PgD.htm',
      title: "140 Cong. Rec. D - Daily Digest/Highlights + Senate",
      date: Date.parse("1994-01-25"),
      section: "Daily Digest"
    }

    pages_table.insert(page_attributes)
    expect(pages_table.first).to include(page_attributes)
  end
end
