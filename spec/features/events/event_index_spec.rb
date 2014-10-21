include Warden::Test::Helpers
Warden.test_mode!

# Feature: Event index page
#   As a user
#   I want to see a list of events
#   So I can see all available events
feature 'Event index page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Event listed on index page
  #   Given I am in Home page
  #   When I visit the user index page
  #   Then I see my list of events
  scenario 'events listing' do
    event_one = FactoryGirl.create(:event)
    FactoryGirl.create(:event, name: 'World Championship')
    visit events_path
    expect(page).to have_content event_one.name
    expect(page).to have_content 'World Championship'
  end

  context 'Event Managements' do
    before(:each) do
      FactoryGirl.create(:event)
    end

    scenario 'dont show the links to add/edit or remove event to a visitor' do
      visit events_path
      within('table#events') do
        expect(page).to_not have_link 'Edit'
        expect(page).to_not have_link 'Destroy'
      end
      expect(page).to_not have_link 'New Event'
    end

    scenario 'shows  the links to add, edit or remove event a logged in user' do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit events_path
      within('table#events') do
        expect(page).to have_link 'Edit'
        expect(page).to have_link 'Destroy'
      end
      expect(page).to have_link 'New Event'
    end
  end

  context "Links for the new events" do
    before(:each) do
      FactoryGirl.create(:event)
    end
    scenario 'shows the links for the tracks' do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit events_path
      within('table#events') do
        expect(page).to have_link 'Tracks'
      end
    end
  end
end
