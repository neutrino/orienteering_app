include Warden::Test::Helpers
Warden.test_mode!

feature 'Results page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    @event = FactoryGirl.create(:event)
    @track = FactoryGirl.create(:track, event: @event)
    @result = FactoryGirl.create(:result, track: @track)
  end

  context "results listing" do
    scenario "should have correct page heading" do
      visit event_track_results_path(@event, @track)
      within('main h1') do
        expect(page).to have_content 'Results'
      end
    end

    scenario "should have correct headings and result details in table" do
      visit event_track_results_path(@event, @track)
      within first('table tr') do
        expect(page).to have_content 'Nick Name'
        expect(page).to have_content 'Total Time'
        expect(page).to have_content 'Completed'
      end
      within('tr', text: @result.nickname) do
        expect(page).to have_content @result.total_time
        expect(page).to have_content "Delete"
      end
    end
  end

  context "Deleting a result" do
    scenario "should be able to delete results" do
      visit event_track_results_path(@event, @track)
      within('tr', text: @result.nickname) do
        expect(page).to have_content "Delete"
        click_link 'Delete'
      end
      expect(page).to have_content "Result was successfully destroyed."
      expect(current_path).to eq event_track_results_path(@event, @track)
    end
  end
end