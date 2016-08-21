require 'spec_helper'
require 'go_verbal/gpo_site'

module GoVerbal
  RSpec.describe "GPOSite Content" do
    context "after #go_to_root is called", :vcr do
      it "is present" do
        site = GPOSite.new
        site.go_to_root

        expect(site.current_page).to have_content
      end
    end
  end
end
