# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    distance "5 KM"
    name "Track 1"
    event_id "1"
    image { fixture_file_upload(Rails.root.join('spec/fixtures/sample_track.jpg'), 'image/jpeg') }
  end
end
