require 'spec_helper'

describe Api::V1::TracksController do
  render_views

  describe "listing of tracks" do
    before(:each) do

      @event = FactoryGirl.create(:event)
      @track = FactoryGirl.create(:track, event: @event)
    end

    it "should be successful" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "should return available tracks in json" do
      get :index, format: :json
      body = JSON.parse(response.body)
      expect(body[0]["name"]).not_to be_empty
      expect(body[0]["name"]).to eq @track.name
    end
  end

  describe "detail of a track" do
    before(:each) do
      @event = FactoryGirl.create(:event)
      @track = FactoryGirl.create(:track, event: @event)
    end

    it "should be successful" do
      get :show, format: :json, id: @track.id
      expect(response).to be_success
    end

    it 'responds with JSON' do
      get :show, format: :json, id: @track.id
      expect { JSON.parse(response.body)}.to_not raise_error
    end

    it "should have track information and event" do
      get :show, format: :json, id: @track.id
      body = JSON.parse(response.body)
      expect(body["name"]).to eq @track.name
      expect(body["info_tag"]).to eq @track.info_tag
      expect(body["event"]).to_not be_blank
    end
  end
end