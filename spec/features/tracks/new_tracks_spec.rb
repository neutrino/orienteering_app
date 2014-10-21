include Warden::Test::Helpers
Warden.test_mode!

# Feature: Tracks of an Event

feature 'New track', :devise do
  after(:each) do
    Warden.test_reset!
  end

  before(:each) do
    @event = FactoryGirl.create(:event)
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end

  scenario 'with valid information' do
    visit new_event_track_path(@event)
    fill_in 'Name', with: 'Track 1'
    fill_in 'Distance', with: '5 KM'
    click_button 'Create Track'

    expect(page).to have_content 'Track was successfully created.'
    expect(page).to have_content 'Track 1'
  end

  scenario 'adding new track without a distance' do
    visit new_event_track_path(@event)
    fill_in 'Name', with: 'Track 1'
    fill_in 'Distance', with: ''
    click_button 'Create Track'
    expect(page).to_not have_content 'Track was successfully created.'
  end

end