require 'spec_helper'

describe Api::V1::EventsController do
  # views rendering are disabled by default for controllers
  # blank body using jbuilder views
  # https://github.com/rails/jbuilder/issues/32
  render_views

  describe "listing of events" do
    before(:each) do
      @event = FactoryGirl.create(:event)
    end

    it "should be successful" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "should return events in json" do
      get :index, format: :json
      body = JSON.parse(response.body)
      expect(body[0]["name"]).not_to be_empty
      expect(body[0]["name"]).to eq @event.name
    end
  end

  describe "detail of an event" do
    before(:each) do
      @event = FactoryGirl.create(:event)
    end

    it "should be successful" do
      get :show, format: :json, id: @event.id
      expect(response).to be_success
    end
    it "should include available events" do
      get :show, format: :json, id: @event.id
      body = JSON.parse(response.body)
      expect(["name"]).not_to be_empty
      expect(body["name"]).to eq @event.name
    end
  end

end