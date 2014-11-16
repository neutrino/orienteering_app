require 'rails_helper'

RSpec.describe Track, :type => :model do

  before(:each) { @track = FactoryGirl.create(:track)}

  subject { @track }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:info_tag) }
  it { should accept_nested_attributes_for :control_points }

  it { should have_many(:control_points) }
  it { should have_many(:results) }

end
