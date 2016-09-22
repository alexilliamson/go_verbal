require 'spec_helper'
require 'go_verbal/scraper'
module GoVerbal
  RSpec.describe Scraper do
    describe "#build_css_query" do
      it "starts with keys and uses values as html attributes" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = {:class => "divy"}

        params = [tag => value]

        query = menu.make_css_query(params)
        expectation = "div" + "[@class='" + "divy" + "']/a"
        expect(query).to eq(expectation)
      end

      it "combines multiple param sets" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = {:class => "divy"}

        params = [{tag => value}, {tag => value}]

        query = menu.make_css_query(params)
        expectation = "div" + "[@class='" + "divy" + "']" +"/div" + "[@class='" + "divy" + "']" + "/a"
        expect(query).to eq(expectation)
      end

      it "doesn't insert brackets when there is no hash" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = {:class => "divy"}

        params = [{tag => value}, :symbol_test]

        query = menu.make_css_query(params)
        expectation = "div" + "[@class='" + "divy" + "']" +"/symbol_test" + "/a"
        expect(query).to eq(expectation)
      end

      it "adds characters before" do
        mapping_double = double("Mapping", css_classes: {})
        menu = described_class.new(browser: nil, mapping: mapping_double)
        tag = :div
        value = {:char_before => '/'}

        params = [{tag => value}]

        query = menu.make_css_query(params)
        expectation = "/div/a"
        expect(query).to eq(expectation)
      end
    end

  end
end
