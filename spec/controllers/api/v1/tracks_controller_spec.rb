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

  describe "search a track" do
    before(:each) do
      @event = FactoryGirl.create(:event)
      @track = FactoryGirl.create(:track, event: @event, info_tag: '45')
    end

    it "should be successful" do
      get :search, format: :json, info_tag: @track.info_tag
      expect(response).to be_success
    end

    it 'responds with JSON' do
      get :search, format: :json, info_tag: @track.info_tag
      expect { JSON.parse(response.body)}.to_not raise_error
    end

    it "should have track information and event" do
      get :search, format: :json, info_tag: @track.info_tag
      body = JSON.parse(response.body)
      expect(body["name"]).to eq @track.name
      expect(body["info_tag"]).to eq @track.info_tag
      expect(body["event"]).to_not be_blank
      expect(body["image_url"]).to_not be_blank
    end
  end

  describe "Adding a result to a track" do
    before(:each) do
      @event = FactoryGirl.create(:event)
      @track = FactoryGirl.create(:track, event: @event)
    end

    it "creates new record" do
      expect{
        post :result, format: :json, id: @track.id, result: { nickname: "Matti", details:{ "26" => 00, "45" => 1200 }}
      }.to change(Result, :count).by(1)
    end
  end

  describe "invalid id" do
    it "should respond with proper error message when record is not found" do
      get :show, format: :json, id: 1234
      body = JSON.parse(response.body)
      expect(response.status).to be 404
      expect(["error"]).not_to be_empty
    end
  end
end