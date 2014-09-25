require 'rails_helper'

describe Event do

  before(:each) { @event = FactoryGirl.create(:event)}

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:location) }
  it { should respond_to(:terrain) }
  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:starting_point) }

end

