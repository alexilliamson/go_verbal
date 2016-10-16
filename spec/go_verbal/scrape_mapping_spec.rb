require 'spec_helper'
require 'go_verbal'
require 'go_verbal/scrape_mapping'
module GoVerbal
  RSpec.describe ScrapeMapping do
    describe "#make_css_query" do
      subject do
        mapping_double = double("Mapping", css_classes: {})
        described_class.new(browser: nil, mapping: mapping_double)
      end

      it "starts with keys and uses values as html attributes" do
        tag = :div
        value = { :class => "divy" }
        params = [tag => value]

        query = subject.make_css_query(params)
        expectation = "div" + "[@class='" + "divy" + "']/a"
        expect(query).to eq(expectation)
      end

      it "combines multiple param sets" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = { :class => "divy" }

        params = [{ tag => value }, { tag => value }]

        query = menu.make_css_query(params)
        expectation = "div" + "[@class='" + "divy" + "']" +"/div" + "[@class='" + "divy" + "']" + "/a"
        expect(query).to eq(expectation)
      end

      it "doesn't insert brackets when there is no hash" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = { :class => "divy" }

        params = [{ tag => value }, :symbol_test]

        query = menu.make_css_query(params)
        expectation = "div" + "[@class='" + "divy" + "']" +"/symbol_test" + "/a"
        expect(query).to eq(expectation)
      end

      it "adds characters before" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = { :char_before => '/' }

        params = [{ tag => value }]

        query = menu.make_css_query(params)
        expectation = "/div/a"
        expect(query).to eq(expectation)
      end
    end

      it "has year" do
        {:year => "div[@class='level1 browse-level']/a", :month => "div[@class='level2 browse-level']/a", :date => "div[@class='level3 browse-level']/a", :section => "div[@class='level4 browse-leaf-level ']/a", :text_page => "table[@class='browse-node-table']//td[@class='browse-download-links']/a" }
      end

  end
end
