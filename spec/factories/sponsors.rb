FactoryGirl.define do

  COUNTRIES = ISO3166::Country.countries.map {|c| c[1]} - ['IL']

  sequence :countries, (0..(COUNTRIES.count - 1)).cycle do |n|
    COUNTRIES[n]
  end

  factory :sponsor do
    name { Faker::Name.name }
    requested_orphan_count (1..10).to_a.sample
    country { generate :countries }
    city { Faker::Address.city }
    gender { %w(Male Female).sample }
    sponsor_type { SponsorType.all[[0,1].sample] }
    branch { Branch.all.sample if sponsor_type.name == 'Individual' }
    organization { Organization.all.sample if sponsor_type.name == 'Organization' }
    payment_plan { Sponsor::PAYMENT_PLANS.sample }
  end
end
