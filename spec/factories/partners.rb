FactoryGirl.define do
  factory :partner_address, class: "FloodRiskEngine::Address" do
    premises            { Faker::Address.building_number }
    street_address      { Faker::Address.street_address }
    locality            { FFaker::AddressUK.neighborhood }
    city                { Faker::Address.city }
    postcode            { generate :uk_post_code }
  end

  factory :partner_contact, class: "FloodRiskEngine::Contact" do
    title 1
    full_name { Faker::Name.name }
    suffix Faker::Name.suffix
    date_of_birth { rand(20..50).years.ago }
    position { Faker::Company.profession }
    email_address { generate(:random_email) }
    telephone_number { Faker::PhoneNumber.phone_number }

    after(:create) { |object| object.address = create :partner_address }
  end

  factory :partner_with_contact, class: "FloodRiskEngine::Partner" do
    association :contact, factory: :partner_contact
  end
end
