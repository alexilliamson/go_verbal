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
      it "extracts texts and strips whitespace" do
        text = double
        element = double(text: "\t\t\ntext\t\t\n")
        nav_menu_mapper = NavMenuMapper.new

        extract = nav_menu_mapper.parse(element)
        expect(extract).to eq("text")
      end
    end
  end
end
