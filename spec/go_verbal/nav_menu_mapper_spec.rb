require 'spec_helper'
require 'go_verbal/nav_menu_mapper'

module GoVerbal
  RSpec.describe NavMenuMapper do
    describe "#build" do
     context "given GPOSite on root page" do
        it "assigns parsed links to nav_menu#years" do
          site = build(:gpo_site_home_page)
          allow(site).to receive(:browse_level_links) {[double]}

          mapper = NavMenuMapper.new(site)
          parsed_link = :parsed_link
          allow(mapper).to receive(:parse) {parsed_link}

          mapper.build

          nav_menu = mapper.nav_menu
          expect(nav_menu.years).to eq([parsed_link])
        end
      end
    end

    describe "#parse" do
      context "when given something with text" do
        it "extracts" do
          text = double
          element = double(text: text)
          nav_menu_mapper = NavMenuMapper.new

          extract = nav_menu_mapper.parse(element)
          expect(extract).to eq(text: text)
        end
      end
    end
  end
end
