include Warden::Test::Helpers
Warden.test_mode!

feature 'Track index page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  before(:each) do
    @event = FactoryGirl.create(:event)
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  scenario 'events listing' do
    visit event_tracks_path(@event)
    expect(page).to have_content 'New Track'
  end
end