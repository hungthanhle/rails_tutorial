require 'rails_helper'

RSpec.describe User, type: :request do
  let (:user) { FactoryBot.create(:user, activated: true) }

  describe "???" do
    let (:emotion) { "haha" }

    before do
      # log_in_as(user)
    end

    it 'Login' do
      post "/login", params:
                          { session: {
                              email: user.email,
                              password: user.password,
                              remember_me: 1
                            }, 
                            authenticity_token: 'bdSlebCVqqOTQGhLwSHUgTzPmAmNlRfNLwIenSp-wssllcoh8r5B-dqdig1MqKKXYmqnu482AVzXXWBvgSM3lA' 
                          }
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/users/#{user.id}")
    end

    it 'Login and react' do
      post "/login", params:
                          { session: {
                            email: user.email,
                            password: user.password,
                            remember_me: 1
                          } }
      micropost = FactoryBot.create(:micropost, content: 'U là tr', user_id: user.id, micropost_id: nil )
      expect{
        post "/reacts", params:
                          { react: {
                            emotion: emotion,
                            micropost_id: micropost.id
                          } } 
      }.to change(React,:count).by(1)
      expect(assigns(:react)).to be_valid
    end

    it 'Login fail and react' do
      post "/login", params:
                          { session: {
                            email: 'user.email',
                            password: 'user.password',
                            remember_me: 1
                          } }
      micropost = FactoryBot.create(:micropost, content: 'U là tr', user_id: user.id, micropost_id: nil )
      post "/reacts", params:
                          { react: {
                            emotion: emotion,
                            micropost_id: micropost.id
                          } } 
      expect(response).to redirect_to('/login')
      expect(response.status).to eq(302)
    end

    it 'Get react is not allowed' do
      post "/login", params:
                          { session: {
                            email: user.email,
                            password: user.password,
                            remember_me: 1
                          } }
      micropost = FactoryBot.create(:micropost, content: 'U là tr', user_id: user.id, micropost_id: nil )
      react = FactoryBot.create(:react, emotion: emotion, user_id: user.id, micropost_id: micropost.id )
      # get "/reacts/#{react.id}" #No route matches
      expect(response.status).to eq(404) #No route matches
    end
  end

end
