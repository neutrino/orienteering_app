require 'rails_helper'

describe Event do

  before(:each) { @event = FactoryGirl.create(:event)}

  subject { @event }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:starting_point) }

  it { should respond_to(:start_date) }

end

