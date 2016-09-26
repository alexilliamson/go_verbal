require 'spec_helper'
require 'go_verbal'

RSpec.describe "a Text Page" do
  context "created via index_enumerator", :vcr do
    it "has a GPOSite url with an .htm extension" do
      index = GoVerbal.build_index
      text_page = index.text_pages.next

      expect(text_page.url).to match(/gpo\.gov.*\.htm/)
    end

    it "can be saved as a document" do
      index = GoVerbal.build_index
      text_page = index.text_pages.next
      database = GoVerbal::DB
      expect{ DocumentMapper.save(text_page) }.to change{database[:documents].count}.from(0).to(1)
    end
  end
end

