class V1::SimulationProposalsController < ApplicationController
  before_action :set_proposal, only: %i[show]

  # GET /v1/simulations.json
  def index
    proposals = SimulationProposal.all
    render json: proposals, status: :ok
  end

  # GET /v1/simulations/1.json
  def show
    render json: @proposal, status: :ok
  end

  private

  def set_proposal
    @proposal = SimulationProposal.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Proposal not found" }, status: :not_found
  end
end
