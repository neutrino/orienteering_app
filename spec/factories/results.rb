# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    nickname "Matti"
    total_time 223764
    complete false
    control_points [{ tag_id: 1, time: 223764 },{ tag_id: 2, time: 223764 },{ tag_id: 3, time: 223764 }]
    track_id 1
  end
end


