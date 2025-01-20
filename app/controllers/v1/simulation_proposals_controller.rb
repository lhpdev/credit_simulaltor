class V1::SimulationProposalsController < ApplicationController
  before_action :set_proposal, only: %i[show]

  # GET /v1/simulations.json
  def index
    proposals = Rails.cache.fetch("simulation_proposals", expires_in: 1.hour) do
      SimulationProposal.all
    end
    render json: proposals, status: :ok
  end

  # GET /v1/simulations/1.json
  def show
    render json: @proposal, status: :ok
  end

  private

  def set_proposal
    @proposal = SimulationProposal.find(params.require(:id))
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: "Proposal not found" }, status: :not_found
  end
end
