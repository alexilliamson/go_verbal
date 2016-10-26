require 'spec_helper'
require 'go_verbal/gpo_site_browser'

module GoVerbal
  RSpec.describe GPOSiteBrowser do
    describe "#go_to" do
      it "changes current_page_menu" do
        internet = instance_double(Internet, give_me: nil)
        site = described_class.new
        site.internet = internet

        expect{  site.go_to("url") }.to change{ site.current_page }
      end
    end
  end
end
