require 'spec_helper'

module GoVerbal
  RSpec.describe Browser do
    describe "#go_to" do
      context "with year_url" do
        it "demands from the internet" do
          browser = described_class
          internet = browser.internet
          expect(internet).to receive(:give_me).with(year_url)


          browser.go_to(year_url)
        end

        def year_url
          "https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC&browsePath=2016&isCollapsed=false&leafLevelBrowse=false&ycord=143"
        end
      end
    end
  end
end
