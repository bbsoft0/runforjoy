require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe StatsController, type: :controller do
  include Devise::Test::ControllerHelpers
  context "when a user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
      @segment=Segment.first
    end
    it "shows the stat index view" do
      get :index, params: {segment_id: @segment.id}
      expect(response).to render_template(:index)
    end
  end

  context "when not an user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:stat]
      @segment=Segment.first
    end
    it "redirects to the home page when trying to view a stat" do
      get :index, params: {segment_id: @segment.id}
      expect(response).to redirect_to(new_user_session_path)
    end
  end


end
