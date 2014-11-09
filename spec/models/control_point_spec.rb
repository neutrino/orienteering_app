require 'rails_helper'

RSpec.describe ControlPoint, :type => :model do

  it { should validate_presence_of(:tag_id) }
  it { should belong_to(:track) }

end
