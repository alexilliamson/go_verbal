require 'spec_helper'
require 'go_verbal'

RSpec.describe "a Text Page" do
  context "created via index_enumerator" do
    it "is a text page" do
      VCR.use_cassette("drill_through_text_page") do
        index = GoVerbal.build_index
        text_page = index.text_pages.next
        expect(text_page).to be_a_kind_of(GoVerbal::TextPage)
      end
    end

    it "has a GPOSite url with an .htm extension" do
      VCR.use_cassette("drill_through_text_page") do
        index = GoVerbal.build_index
        text_page = index.text_pages.next

        expect(text_page.url).to match(/gpo\.gov.*\.htm/)
      end
    end

    it "has title" do
      VCR.use_cassette("drill_through_text_page") do
        index = GoVerbal.build_index
        text_page = index.text_pages.next

        expect(text_page).to have_attributes(title: "140 Cong. Rec. D - Daily Digest/Highlights + Senate")
      end
    end
  end
end

