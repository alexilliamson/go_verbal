require 'spec_helper'
require 'go_verbal'

RSpec.describe "an enumerated item from the index" do
  describe "a year", :vcr do
    it "has an url from the GPO domain" do
      index = GoVerbal.build_index
      years = index.years
      year = years.next
      expect(year.url).to start_with("https://www.gpo.gov/fdsys/browse/")
    end

    it "has a year between 1994 and current year" do
      index = GoVerbal.build_index
      years = index.years
      year = years.next
      expect(years_since_1994).to include(year.value)
    end

    def years_since_1994
      current_date = Date.today
      current_year = current_date.year
      first_recorded_year = 1994

      years = (first_recorded_year..current_year).to_a

      years.map(&:to_s)
    end
  end

  describe "a month", :vcr do
    it "has a value from the GPOSite domain" do
      index = GoVerbal.build_index
      months = index.months
      month = months.next
      expect(month.value).to eq("January")
    end

    it "has a url from the GPOSite domain" do
      index = GoVerbal.build_index
      months = index.months
      month = months.next
      expect(month.url).to start_with("https://www.gpo.gov/fdsys/browse/")
    end
  end

  describe "a day", :vcr do
    describe "#url" do
      it "has a url from the GPOSite domain" do
        index = GoVerbal.build_index
        dates = index.dates
        date = dates.next

        expect(date.url).to start_with("https://www.gpo.gov/fdsys/browse/")
      end
    end

    describe "#value" do
      it "contains a weekday" do
        index = GoVerbal.build_index

        dates = index.dates
        date = dates.next
        date_value = date.value

        weekday_match = weekdays.detect do |wkd|
          wkd =~ date_value
        end

        expect(weekday_match).to be_truthy
      end

      it "contains a month" do
        index = GoVerbal.build_index

        dates = index.dates
        date = dates.next
        date_value = date.value

        month_match = month_names.detect do |month|
          month =~ date_value
        end

        expect(month_match).to be_truthy
      end

      def weekdays
        Date::DAYNAMES.map { |name| /#{ name.downcase }/i }
      end

      def month_names
        Date::MONTHNAMES.compact.map { |name| /#{ name.downcase }/i }
      end
    end
  end

  describe "its type" do
    specify "is :year", :vcr do
      element = GoVerbal::build_index.years.next
      expect(element.type).to eq(:year)
    end

    specify "a month", :vcr do
      element = GoVerbal::build_index.months.next
      expect(element.type).to eq(:month)
    end

    specify "a date", :vcr do
      element = GoVerbal::build_index.dates.next
      expect(element.type).to eq(:date)
    end

    specify "a section", :vcr do
      element = GoVerbal::build_index.sections.next
      expect(element.type).to eq(:section)
    end
  end

  describe "a section"do
    describe "#value" do
      it "is one of the four sections of text" do
        VCR.use_cassette("urls", :allow_unused_http_interactions => false) do
          index = GoVerbal.build_index

          sections = index.sections
          section = sections.next
          section_value = section.value

          section_match = section_names.detect do |sec|
            sec =~ section_value
          end

          expect(section_match).to be_truthy
        end

      end

      it "has a url from the GPOSite domain" do
        VCR.use_cassette("urls", :allow_unused_http_interactions => false) do
          index = GoVerbal.build_index
          sections = index.sections
          section = sections.next

          expect(section.url).to start_with("https://www.gpo.gov/fdsys/browse/")
        end
      end

      def section_names
        GoVerbal::SECTIONNAMES.compact.map { |name| /#{ name.downcase }/i }
      end

    end
  end
end
