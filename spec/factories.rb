# spec/factories.rb
# Load with: RSpec.configure { |c| c.include FactoryBot::Syntax::Methods }
# If you prefer, you can `require_relative "factories"` from spec_helper/rails_helper.

FactoryBot.define do
  # --- CaseType / Case -------------------------------------------------------
  factory :case_type do
    sequence(:name) { |n| "Case Type #{n}" }
  end

  factory :case do
    association :case_type
    sequence(:name)    { |n| "Case #{n}" }
    sequence(:acronym) { |n| "C#{n}" }
  end

  # --- ItemType / Item / ItemComment ----------------------------------------
  factory :item_type do
    sequence(:name) { |n| "Type #{n}" }
  end

  factory :item do
    association :case
    association :item_type

    sequence(:name)         { |n| "Item #{n}" }
    description             { "Test description" }
    manufacturer            { "TestCo" }
    model                   { "Model X" }
    date_of_purchase        { Date.today - 365 }
    price                   { 42.00 }
    serial_number           { SecureRandom.hex(6) }
    broken                  { false }
    missing                 { false }
    deleted                 { false }

    # optional self-references you can opt into via traits
    trait :with_parent do
      association :item, factory: :item
    end

    trait :with_location_item do
      association :location, factory: :item # location_item_id -> Item
    end

    trait :deleted do
      deleted { true }
    end
  end

  factory :item_comment do
    association :item
    comment { "Looks good" }
    author  { "SpecUser" }
  end

  # --- Events / Transports / EventCase --------------------------------------
  factory :event do
    sequence(:name) { |n| "Event #{n}" }
    start_date { Date.today + 7 }
    end_date   { Date.today + 9 }
    buildup    { start_date.to_time.change(hour: 8) }
    removel    { end_date.to_time.change(hour: 18) }
    location   { "Somewhere" }
  end

  factory :transport do
    source_address       { "Source St. 1" }
    destination_address  { "Dest Ave. 2" }
    pickup_time          { Time.current + 3.days }
    delivery_time        { Time.current + 5.days }
    pickup_timeframe     { 60 }
    delivery_timeframe   { 60 }
    pickup_contact       { "Alice <alice@example.com>" }
    delivery_contact     { "Bob <bob@example.com>" }
    quotation            { false }
    ordered              { false }
    carrier              { "CarrierCo" }
    destination_event_id { nil }
    source_event_id      { nil }
    tracking_number      { SecureRandom.hex(8) }
    shipment_id          { nil }
    delivery_state       { "planned" }
    actual_pickup_time   { nil }
    actual_delivery_time { nil }
  end

  factory :event_case do
    association :event
    association :case
    # check_list and transport are optional in schema; add via traits when needed

    trait :with_check_list do
      association :check_list
    end

    trait :with_transport do
      association :transport
    end
  end

  # --- CheckLists ------------------------------------------------------------
  factory :check_list do
    comment { "Checklist for shipment" }
    advisor { "Advisor Name" }
    checked { false }
  end

  factory :check_list_item do
    association :check_list
    association :item
    association :case

    broken  { false }
    missing { false }
    comment { "All good" }
    checked { false }
  end
end