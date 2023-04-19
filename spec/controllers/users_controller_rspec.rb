require 'rails_helper'

# require './spec/support/test_helpers'
# RSpec.configure do |c|
#   c.include TestHelpers
# end

RSpec.describe UsersController do
  describe "this describe's message" do
    it "this first test's message" do
      expect(true).to eq(true)
    end
  end

  describe 'GET index' do
    let (:user) { FactoryBot.create :user }
    # let (:user) { create :user } # fail
    # user = Factory(:user) # fail
    before do
      log_in_as(user)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

    it "assigns @users" do
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET #show" do
    let (:user) { FactoryBot.create :user }
    
    before do
      log_in_as(user)
      get :show, params: { id: user.id }
    end
    
    it "assigns the requested user to @user" do
      # get :show, id: user.id #fail
      # get :show #fail
      expect(assigns(:user)).to eq(user)
    end
    
    it "renders the #show view" do
      expect(response).to render_template :show
      expect(response).to have_http_status(:success)
    end
  end

end
