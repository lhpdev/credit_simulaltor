require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /show" do
    context "when user is logged out" do
      it "returns http success" do
        get "/dashboard/show"
        expect(response).to redirect_to("/session/new")
      end
    end
  end
end
