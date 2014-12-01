require 'rails_helper'

RSpec.describe Result, :type => :model do
  it { should respond_to(:complete) }
  it { should respond_to(:control_points) }
  it { should respond_to(:total_time) }

  it { should belong_to(:track) }
end
