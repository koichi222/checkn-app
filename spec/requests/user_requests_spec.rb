require 'rails_helper'

RSpec.describe "UserRequests", type: :request do
  describe "GET /user_requests" do
    it "works! (now write some real specs)" do
      get user_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
