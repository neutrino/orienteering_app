require 'rails_helper'

RSpec.describe Track, :type => :model do

  before(:each) { @track = FactoryGirl.create(:track)}

  subject { @track }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:distance) }
end
