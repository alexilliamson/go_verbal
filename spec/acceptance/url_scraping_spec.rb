require 'spec_helper'

module GoVerbal
  RSpec.describe "when looking for congressional record text URLs" do
      context "by searching the GPO Site's NavMenu" do
        it "the first yielded result is a text_page_url" do
          gpo_nav_menu = GoVerbal.load_nav_menu

          search_result = search_menu_until_result(gpo_nav_menu)
        
          expect(search_result).to be_a_kind_of(TextPageURL)
        end
    end

    def search_menu_until_result(menu)
      result = :not_a_url

      menu.search_for_text_page_urls do |yielded_thing|
          result =  yielded_thing
          break
      end

      return result
    end
  end
end