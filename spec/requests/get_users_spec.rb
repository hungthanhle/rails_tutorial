require 'rails_helper'

RSpec.describe User, type: :request do
  let (:user) { FactoryBot.create :user }

  describe "GET" do
    before do
      # log_in_as(user)
      post "/login", params:
                          { session: {
                            email: user.email,
                            password: user.password
                          } }
    end

    it 'Get users' do
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
    end

    # it 'Fail login' do
    #   post "/login", params:
    #                       { session: {
    #                         email: 'a',
    #                         password: user.password
    #                       } }
    #   expect(response.status).to eq(200)
    # end

    # it 'Get react is not allowed' do
    #   micropost = FactoryBot.create(:micropost, content: 'U là tr', user_id: user.id, micropost_id: nil )
    #   react = FactoryBot.create(:react, emotion: "haha", user_id: user.id, micropost_id: micropost.id )
    #   get "/reacts/#{react.id}", params: { id: react.id }
    #   expect(response.status).to eq(404)
    # end
  end

end
