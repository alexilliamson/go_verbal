require 'spec_helper'

module GoVerbal
  RSpec.describe Crawler do
    describe "#go_to_root" do
      it "goes to GPOSite root" do
        site = instance_double(GPOSite)
        crawler = described_class.new(site)

        expect(site).to receive(:go_to_root)

        crawler.go_to_root
      end
    end
  end
end
