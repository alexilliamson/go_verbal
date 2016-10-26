require 'spec_helper'
require 'go_verbal'

RSpec.describe "Index Enumerations" do
  describe "a year" do
    subject do
      VCR.use_cassette("drill_through_content") do
        index = GoVerbal.build_index
        index.listings.next
      end
    end

    it "is a month link from the GPO site" do
      expect(subject.url).to start_with("https://www.gpo.gov/fdsys/browse/")
      expect(years_since_1994).to include(subject.value)
      expect(subject.type).to eq(:year)
    end

    def years_since_1994
      current_date = Date.today
      current_year = current_date.year
      first_recorded_year = 1994

      years = (first_recorded_year..current_year).to_a
      years.map(&:to_s)
    end
  end

  describe "a month" do
    subject do
      VCR.use_cassette("drill_through_content") do
        index = GoVerbal.build_index
        listings = index.listings
        year = listings.next
        month =listings.next
      end
    end

    it "is a January/month link from the gpo site" do
      expect(subject.value).to eq("January")
      expect(subject.url).to start_with("https://www.gpo.gov/fdsys/browse/")
      expect(subject.type).to eq(:month)
    end
  end

  describe "a day" do
    subject do
      VCR.use_cassette("drill_through_content") do
        index = GoVerbal.build_index
        listings = index.listings
        year = listings.next
        month =listings.next
        date = listings.next
      end
    end

    it "has a url from the GPOSite domain" do
      expect(subject.url).to start_with("https://www.gpo.gov/fdsys/browse/")
    end

    it "contains a weekday" do
      date_value = subject.value
      weekday_match = weekdays.detect { |wkd| wkd =~ date_value }

      expect(weekday_match).to be_truthy
    end

    it "contains a month" do
      date_value = subject.value
      month_match = month_names.detect{ |month| month =~ date_value }

      expect(month_match).to be_truthy
    end

    it "has type :date" do
      expect(subject.type).to eq(:date)
    end

    def weekdays
      Date::DAYNAMES.map { |name| /#{ name.downcase }/i }
    end

    def month_names
      Date::MONTHNAMES.compact.map { |name| /#{ name.downcase }/i }
    end
  end

  describe "a section" do
    subject do
      VCR.use_cassette("drill_through_content") do
        index = GoVerbal.build_index
        listings = index.listings
        year = listings.next
        month =listings.next
        date = listings.next
        section = listings.next
      end
    end

    describe "#value" do
      it "is one of the four sections of text" do
        section_value = subject.value

        section_match = section_names.detect do |sec|
          sec =~ section_value
        end

        expect(section_match).to be_truthy
      end
    end

    it "has a url from the GPOSite domain" do
      expect(subject.url).to start_with("https://www.gpo.gov/fdsys/browse/")
    end

    specify "has section type" do
      expect(subject.type).to eq(:section)
    end

    def section_names
      GoVerbal::SECTIONNAMES.compact.map { |name| /#{ name.downcase }/i }
    end
  end
end
