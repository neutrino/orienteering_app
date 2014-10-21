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
    @track = FactoryGirl.create(:track, name: 'Track 1', distance: '5 KM.')
    login_as(@user, :scope => :user)
  end


  scenario 'with valid information' do
    visit edit_event_track_path(@event, @track)
    fill_in 'Name', with: 'Track 2'
    fill_in 'Distance', with: '15 KM'
    click_button 'Update Track'

    expect(page).to have_content 'Track was successfully updated.'
    @track.reload()
    expect(@track.name).to eq 'Track 2'
    expect(@track.distance).to eq '15 KM'
  end

end