# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :track do
    distance "5 KM"
    name "Track 1"
    event_id "1"
    image_file_name { 'image.jpeg' }
    image_content_type { 'image/jpeg' }
    image_file_size { 1024 }
  end
end
