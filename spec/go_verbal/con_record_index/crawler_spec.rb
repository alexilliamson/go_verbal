require 'spec_helper'
require 'go_verbal/con_record_index/crawler'

module GoVerbal
  RSpec.describe Crawler do
    describe "#find_index_date" do
      it "searches on the page of the month containing the date" do
        month_url = double
        gpo_site = double
        date = build(:date)

        crawler = Crawler.new

        expect(gpo_site).to receive(:get_page).with(month_url)

        crawler.find_index_date(date)
      end
    end
  end
end
