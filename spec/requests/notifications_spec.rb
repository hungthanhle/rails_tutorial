require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "GET /read" do
    it "returns http success" do
      get "/notifications/read"
      expect(response).to have_http_status(:success)
    end
  end

end
