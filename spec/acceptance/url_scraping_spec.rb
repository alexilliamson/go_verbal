require 'spec_helper'
require 'go_verbal'

RSpec.describe "Each page containing congressional record text" do
  context "for a given date" do
    it "can be found using the ConRecordIndex" do
      index = GoVerbal.get_con_record_index
      date = date_with_record_text

      urls = index.pages(date: date)

      expect(urls).to include(a_kind_of(text_page_url_class))
    end

    def date_with_record_text
      Date.new(2016,1,6)
    end

    def text_page_url_class
      text_page_url_class = GoVerbal::TextPageURL
    end
  end
end
