# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    distance "5 KM"
    name "Track 1"
    event_id "1"
  end
end
