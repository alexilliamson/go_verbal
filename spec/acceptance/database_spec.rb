require 'spec_helper'
require 'go_verbal'

RSpec.describe "the database" do
  it "can store a page of congressional record text in the pages table" do
    DB = Sequel.sqlite('test.db')
    pages_table = DB[:pages]

    expect(pages_table.first).to have_attributes(page_attributes)
  end
end
