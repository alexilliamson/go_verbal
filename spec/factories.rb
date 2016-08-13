require 'go_verbal'

FactoryGirl.define do
  factory :date do
  end

  factory :gpo_site, class: GoVerbal::GPOSite do
    factory :gpo_site_home_page do
    end
  end
end
