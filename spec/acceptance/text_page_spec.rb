require 'spec_helper'
require 'go_verbal'

RSpec.describe "a Text Page" do
  context "created via index_enumerator" do
    subject do
      VCR.use_cassette("drill_through_content") do
        index = GoVerbal.build_index
        listings = index.listings
        year = listings.next
        month =listings.next
        date = listings.next
        section = listings.next
        text_page = listings.next
        text_page.content
        text_page
      end
    end

    it "is an HTML text page" do
      expect(subject).to be_a_kind_of(GoVerbal::HTMLTextPage)
    end

    it "has a GPOSite url with an .htm extension" do
      expect(subject.url).to match(/gpo\.gov.*\.htm/)
    end

    it "has a GPOSite url with an .htm extension" do
      expect(subject.url).to match(/gpo\.gov.*\.htm/)
    end

    it "has title" do
      expect(subject).to have_attributes(title: "140 Cong. Rec. D - Daily Digest/Highlights + Senate")
    end

    it "has content" do
      expect(subject.content).to include("FIRST SESSION OF THE ONE HUNDRED THIRD CONGRESS")
    end

    it "has a date" do
      expect(subject.date).to eq(Date.parse("1994-01-25"))
    end

    it "has a section" do
      expect(subject.section).to eq("Daily Digest")
    end
  end
end

