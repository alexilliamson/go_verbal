require 'spec_helper'
require 'go_verbal/nokogiri_html_doc_wrapper'

module GoVerbal
  RSpec.describe NokogiriHTMLDocWrapper do
    describe ".new" do
      def valid_html_string
        "<!DOCTYPE html>\n<html>\n<body>\n<h1>My First Heading</h1>\n<p>My first paragraph.</p>\n</body>\n</html>"
      end

      it "turns html string into Nokogiri::HTML::Document and stores it in #content" do
        html_string = valid_html_string
        wrapper = NokogiriHTMLDocWrapper.new(valid_html_string)

        expect(wrapper.content).to be_a_kind_of(Nokogiri::HTML::Document)
      end
    end
  end
end
