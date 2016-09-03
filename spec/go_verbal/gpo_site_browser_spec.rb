require 'spec_helper'
require 'go_verbal/gpo_site_browser'

module GoVerbal
  RSpec.describe GPOSiteBrowser do
    describe "#go_to" do
      it "demands content from the internet" do
        internet = instance_double(Internet)

        site = described_class.new
        site.internet = internet

        year_url = double

        expect(internet).to receive(:give_me).with(year_url)

        site.go_to(year_url)
      end

      it "updates current_page_menu" do
        internet = instance_double(Internet, give_me: nil)
        site = described_class.new
        site.internet = internet

        expect{ site.go_to("url")}.to change{site.current_page_menu}
      end
    end
  end
end
