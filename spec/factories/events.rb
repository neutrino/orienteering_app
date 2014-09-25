# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "European Youth Orienteering Championships 2015"
    location "Cluj Napoca, Romania"
    terrain "MyString"
    start_date "2015-06-25"
    end_date "2015-06-28"
    starting_point "MyText"
  end
end



