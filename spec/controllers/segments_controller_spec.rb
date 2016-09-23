require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe SegmentsController, type: :controller do
  include Devise::Test::ControllerHelpers
  context "when a user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
    end
    it "shows the segment index view" do
      get :index
      expect(response).to render_template(:index)
    end
    it "ads a new segment" do
      segment = FactoryGirl.create(:segment)
      get :new
      expect(response).to render_template(:new)
    end
    it "edits a segment" do
      segment = FactoryGirl.create(:segment)
      get :edit,  params: { id: segment.id }
      expect(response).to render_template(:edit)
    end
    it "updates a segment" do
      segment = FactoryGirl.create(:segment)
      process :update, method: :post, params: {id: segment.id, segment: {id: segment.id, name: 'MySegment'}}
      expect(response).to redirect_to(segment_path)
    end

    it "doesn't update a segment when the name is empty" do
      segment = FactoryGirl.create(:segment)
      process :update, method: :post, params: {id: segment.id, segment: {id: segment.id, name: 'MySegment'}}
      expect(response).to redirect_to(segment_path)
    end
    it "can delete a segment" do
      segment = FactoryGirl.create(:segment)
      delete :destroy, params: { id: segment.id }
      expect(response).to redirect_to(segments_url)
    end
  end

  context "when not an user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:segment]
    end
    it "redirects to the home page when trying to add a new segment" do
      segment = FactoryGirl.create(:segment)
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end


end
