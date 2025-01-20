class V1::SimulationsController < ApplicationController
  before_action :set_simulation, only: %i[show update destroy]

  # GET /v1/simulations.json
  def index
    simulations = Rails.cache.fetch("simulations", expires_in: 1.hour) do
      Simulation.all
    end
    render json: simulations, status: :ok
  end

  # GET /v1/simulations/1.json
  def show
    render json: @simulation, status: :ok
  end

  # POST /v1/simulations.json
  def create
    @simulation = Simulation.new(simulation_params)

    if @simulation.save
      ProcessSimulationJob.perform_later(@simulation.id)
      render json: @simulation, status: :ok
    else
      render json: { error: "Simulation could not be created", details: @simulation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/simulations/1.json
  def update
    if @simulation.update(simulation_params)
      ProcessSimulationJob.perform_later(@simulation.id)
      render json: @simulation, status: :ok
    else
      render json: { error: "Simulation could not be updated", details: @simulation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /v1/simulations/1.json
  def destroy
    @simulation.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed
    render json: { error: "Failed to delete simulation" }, status: :unprocessable_entity
  end

  private

  def set_simulation
    @simulation = Simulation.find(params.require(:id))
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Simulation not found" }, status: :not_found
  end

  def simulation_params
    params.require(:simulation).permit(:value, :birthdate, :term_in_months, :user_id)
  end
end
