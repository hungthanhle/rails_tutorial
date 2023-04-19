require 'rails_helper'

RSpec.describe ReactsController do
  let (:user) { FactoryBot.create :user }
  let (:micropost) {
    FactoryBot.create(:micropost, content: 'U là tr', user_id: user.id, micropost_id: nil )
  }

  describe 'POST' do
    let (:emotion) { "haha" }
    before do
      log_in_as(user)
    end

    it "creates a new record" do
      expect{
        post :create, params:
                          { react: {
                            emotion: emotion,
                            micropost_id: micropost.id
                          } } 
      }.to change(React,:count).by(1)
      expect(assigns(:react)).to be_valid
    end


    it 'returns a status' do
      post :create, params:
                          { react: {
                            emotion: emotion,
                            micropost_id: micropost.id
                          } }
      expect(response).to have_http_status(302)
    end

    it 'returns the emotion' do
      post :create, params:
                          { react: {
                            emotion: emotion,
                            micropost_id: micropost.id
                          } }
      expect(assigns(:react).emotion).to eq(emotion)
    end

    it 'emotion of post content' do
      post :create, params:
                          { react: {
                            emotion: emotion,
                            micropost_id: micropost.id
                          } }
      expect(assigns(:react).micropost.content).to eq('U là tr')
    end
  end

  describe 'UPDATE' do
    let (:emotion) { "love" }
    before do
      log_in_as(user)
      react = FactoryBot.create(:react, emotion: "haha", user_id: user.id, micropost_id: micropost.id )
      put :update, params:
                          { id: react.id,
                            react: {
                              emotion: emotion,
                              micropost_id: micropost.id
                          } } 
    end

    it "reaction record" do
      expect(assigns(:react)).to be_valid
    end

    it 'returns a status' do
      expect(response).to have_http_status(302)
    end

    it 'returns the emotion' do
      expect(assigns(:react).emotion).to eq(emotion)
    end

    it 'emotion of post content' do
      expect(assigns(:react).micropost.content).to eq('U là tr')
    end
  end

  describe "DELETE" do
    let (:emotion) { "love" }
    let (:react) { FactoryBot.create(:react, emotion: emotion, user_id: user.id, micropost_id: micropost.id ) } 
    before do
      log_in_as(user)
      
    end
    
    it 'reaction record' do
      id = react.id
      expect{
        delete :destroy, params: { id: id } 
      }.to change(React,:count).by(-1)
    end

    it 'returns a status' do
      delete :destroy, params: { id: react.id }
      expect(response).to have_http_status(302)
    end
  end

end
