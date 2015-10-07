require "rails_helper"

RSpec.describe UserRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_requests").to route_to("user_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/user_requests/new").to route_to("user_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/user_requests/1").to route_to("user_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_requests/1/edit").to route_to("user_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_requests").to route_to("user_requests#create")
    end

    it "routes to #update" do
      expect(:put => "/user_requests/1").to route_to("user_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_requests/1").to route_to("user_requests#destroy", :id => "1")
    end

  end
end
