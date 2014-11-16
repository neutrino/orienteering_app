require 'rails_helper'

RSpec.describe Result, :type => :model do
  it { should belong_to(:track) }
end
