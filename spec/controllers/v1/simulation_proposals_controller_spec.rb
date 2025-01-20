require 'rails_helper'

RSpec.describe V1::SimulationProposalsController, type: :controller do
  let(:user) { create(:user) }
  let(:simulation) { create(:simulation) }

  describe 'GET #index' do
    # Test the `index` action
    before(:each) do
      SimulationProposal.destroy_all

      5.times do
        create(:simulation_proposal, user_id: user.id, simulation_id: simulation.id)
      end
    end

    it 'returns a list of simulation proposals with status 200' do
      get :index

      # Check if the response is successful and the returned JSON is an array
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response.size).to eq(5)
    end

    it 'caches the list of proposals for 1 hour' do
      expect(Rails.cache).to receive(:fetch).with('simulation_proposals', expires_in: 1.hour).and_call_original
      get :index
    end
  end

  # Test the `show` action
  describe 'GET #show' do
    context 'when the proposal exists' do
      let(:proposal) { SimulationProposal.first }

      it 'returns the proposal with status 200' do
        get :show, params: { id: proposal.id }

        expect(response).to have_http_status(:ok)
        expect(json_response['simulation_id']).to eq(proposal.simulation_id)
        expect(json_response['_id']).to eq(proposal._id.to_s)
      end
    end

    context 'when the proposal does not exist' do
      let(:invalid_id) { 99999 }  # Assuming this ID does not exist

      it 'returns an error with status 404' do
        get :show, params: { id: invalid_id }

        # Check if the response returns an error message
        expect(response).to have_http_status(:not_found)
        expect(json_response['error']).to eq('Proposal not found')
      end
    end
  end

  # Helper to parse JSON response
  def json_response
    JSON.parse(response.body)
  end
end
