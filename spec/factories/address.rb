require 'faker'
require 'factory_girl'

FactoryGirl.define do

  factory :address do
    line1 { [Faker::Address.building_number, Faker::Address.street_name].join(" ") }
    line2 { Faker::Address.city }
    city { Faker::Address.city }
    country "UK"
    postcode "EH14 6GT"
  end
end
