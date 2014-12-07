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

  context "remove associated records" do
    before(:each) do
      @track = FactoryGirl.create(:track)
      FactoryGirl.create(:control_point, tag_id: 15, track: @track)
      FactoryGirl.create(:control_point, tag_id: 16, track: @track, position: 2)
    end
    it "destroys relevant control_points" do
      expect(@track.control_points.count).to be 2
      @track.destroy
      expect(Track.all).to_not include(@track)
      expect(ControlPoint.all.count).to be 0
    end
  end

end
