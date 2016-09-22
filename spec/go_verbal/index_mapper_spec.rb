require 'spec_helper'
require 'go_verbal/index_mapper'

module GoVerbal
  RSpec.describe IndexMapper do
    describe "#map_url" do
      context "when type is :text_page" do
        it "uses href" do
          mapping_double = double("Mapping", ordered_index_types: nil)
          mapper = described_class.new(scraper: nil, mapping: mapping_double)
          element = double("Element", type: :text_page, attributes: {href: "google.com"})
          element_type = :text_page

          mapped_url = mapper.map_url(element, element_type)
          expect(mapped_url).to eq(element.attributes["href"])
        end
      end
    end
  end
end


#         scraper = double("Scraper")
#         mapper = described_class.new(scraper: scraper, mapping: mapping )
#         unmapped_element = double("Unmapped", text: "Text", attributes: {})
#         element_type = :type_to_test

#         mapped_element = mapper.map_element(unmapped_element, element_type)
#         expect(mapped_element.type).to eq(element_type)
#       end

#       # it "sets child_type" do
#       #   ordered_index_types = [:type_to_test, :next_level]
#       #   scraper = double("Scraper")
#       #   mapper = described_class.new(scraper, ordered_index_types)
#       #   unmapped_element = double("Unmapped", text: "Text", attributes: {})
#       #   element_type = :type_to_test


#       #   mapped_element = mapper.map_element(unmapped_element, element_type)
#       #   expect(mapped_element.child_type).to eq(:next_level)
#       # end

#       # context "when type is section" do
#       #   it "uses fourth sibling text" do
#       #     ordered_index_types = [:section]
#       #     scraper = double("Scraper")
#       #     mapper = described_class.new(scraper, ordered_index_types)
#       #     sibling_text = "ha"
#       #     sibling_double = double("sibling_double", text: sibling_text)
#       #     parent = double("Parent", children: [nil,nil,nil,nil,sibling_double])
#       #     unmapped_element = double("Unmapped", attributes: {}, parent: parent)
#       #     element_type = :type_to_test


#       #     mapped_element = mapper.map_element(unmapped_element, :section)

#       #     expect(mapped_element.value).to eq(sibling_text)
#       #   end
#       end
#     end
#   end
# end
