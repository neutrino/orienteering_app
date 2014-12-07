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

  context "active events" do
    before(:each) do
      @event_one = FactoryGirl.create(:event,
        start_date: Time.now - 5.days,
        end_date: Time.now - 2.days)
      @event_two = FactoryGirl.create(:event,
        start_date: Time.now - 5.days,
        end_date: Time.now + 1.days)
    end
    it ".active returns the events that are currently active" do
      expect(Event.active).to include @event_two
      expect(Event.active.count).to be 1
    end

    it "active? to check the event status" do
      expect(@event_one.active?).to be false
      expect(@event_two.active?).to be true
    end
  end

end
