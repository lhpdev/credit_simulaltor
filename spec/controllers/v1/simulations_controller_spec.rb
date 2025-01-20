require 'rails_helper'

RSpec.describe V1::SimulationsController, type: :request do
  let(:valid_attributes) { { value: 2000, birthdate: "1990-01-01", term_in_months: 24, user_id: create(:user).id } }
  let(:invalid_attributes) { { value: nil, birthdate: nil, term_in_months: nil, user_id: nil } }

  before do
    Rails.cache.clear
    Simulation.destroy_all
    User.destroy_all
  end

  describe "GET /v1/simulations" do
    before do
      create(:simulation, user: create(:user))
    end

    it "returns all simulations (caching enabled)" do
      get "/v1/simulations.json"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /v1/simulations/:id" do
    let(:simulation) { create(:simulation, user: create(:user)) }

    it "returns the requested simulation" do
      get "/v1/simulations/#{simulation.id}.json"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(simulation.id)
    end

    it "returns 404 if simulation does not exist" do
      get "/v1/simulations/999999.json"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Simulation not found")
    end
  end

  describe "POST /v1/simulations" do
    it "creates a new simulation and enqueues a background job" do
      expect {
        post "/v1/simulations.json", params: { simulation: valid_attributes }
      }.to change(Simulation, :count).by(1)

      expect(response).to have_http_status(:ok)

      # Ensure background job is enqueued
      expect(ProcessSimulationJob).to have_been_enqueued.with(Simulation.last.id)
    end

    it "returns an error when params are invalid" do
      post "/v1/simulations.json", params: { simulation: invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Simulation could not be created")
    end
  end

  describe "PATCH /v1/simulations/:id" do
    let(:simulation) { create(:simulation, user: create(:user)) }

    it "updates the simulation and enqueues a job" do
      patch "/v1/simulations/#{simulation.id}.json", params: { simulation: { value: 5000 } }

      expect(response).to have_http_status(:ok)
      expect(simulation.reload.value).to eq(5000)

      expect(ProcessSimulationJob).to have_been_enqueued.with(simulation.id)
    end

    it "returns an error if update fails" do
      patch "/v1/simulations/#{simulation.id}.json", params: { simulation: invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Simulation could not be updated")
    end
  end

  describe "DELETE /v1/simulations/:id" do
    let!(:simulation) { create(:simulation, user: create(:user)) }

    it "deletes the simulation" do
      expect {
        delete "/v1/simulations/#{simulation.id}.json"
      }.to change(Simulation, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns an error if deletion fails" do
      allow_any_instance_of(Simulation).to receive(:destroy).and_raise(ActiveRecord::RecordNotDestroyed)

      delete "/v1/simulations/#{simulation.id}.json"

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Failed to delete simulation")
    end
  end
end
