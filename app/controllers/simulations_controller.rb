class SimulationsController < ApplicationController
  before_action :set_simulation, only: %i[show update destroy]

  # GET /simulations.json
  def index
    simulations = Simulation.all
    render json: simulations, status: :ok
  end

  # GET /simulations/1.json
  def show
    render json: @simulation, status: :ok
  end

  # POST /simulations.json
  def create
    @simulation = Simulation.new(simulation_params)

    if @simulation.save
      ProcessSimulationJob.perform_later(@simulation.id)
      render json: @simulation, status: :created
    else
      render json: { error: "Simulation could not be created", details: @simulation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /simulations/1.json
  def update
    if @simulation.update(simulation_params)
      ProcessSimulationJob.perform_later(@simulation.id)
      render json: @simulation, status: :updted
    else
      render json: { error: "Simulation could not be updated", details: @simulation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /simulations/1.json
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
