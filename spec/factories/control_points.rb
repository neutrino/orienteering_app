# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :control_point do
    tag_id "MyString"
    position 1
    track_id 1
  end
end
