require "rails_helper"

RSpec.describe V1::SimulationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/simulations").to route_to("v1/simulations#index")
    end

    it "routes to #show" do
      expect(get: "/v1/simulations/1").to route_to("v1/simulations#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/v1/simulations").to route_to("v1/simulations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/v1/simulations/1").to route_to("v1/simulations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/v1/simulations/1").to route_to("v1/simulations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/v1/simulations/1").to route_to("v1/simulations#destroy", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/v1/simulations/1/edit").to route_to("v1/simulations#edit", id: "1")
    end
  end
end
