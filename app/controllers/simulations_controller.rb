class SimulationsController < ApplicationController
  before_action :set_simulation, only: %i[ show edit update destroy ]
  allow_unauthenticated_access

  # GET /simulations or /simulations.json
  def index
    @simulations = Simulation.all
  end

  # GET /simulations/1 or /simulations/1.json
  def show
  end

  # GET /simulations/new
  def new
    @simulation = Simulation.new
  end

  # GET /simulations/1/edit
  def edit
  end

  # POST /simulations or /simulations.json
  def create
    @simulation = Simulation.new(simulation_params)
    respond_to do |format|
      if @simulation.save
        @proposal = CreditSimulationService.new(
          loan_value: @simulation.value,
          birthdate: @simulation.birthdate,
          terms_in_months: @simulation.term_in_months
        ).call

        format.html { redirect_to @simulation, notice: "Simulation was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /simulations/1 or /simulations/1.json
  def update
    respond_to do |format|
      if @simulation.update(simulation_params)
        format.html { redirect_to @simulation, notice: "Simulation was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /simulations/1 or /simulations/1.json
  def destroy
    @simulation.destroy!

    respond_to do |format|
      format.html { redirect_to simulations_path, status: :see_other, notice: "Simulation was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simulation
      @simulation = Simulation.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def simulation_params
      params.require(:simulation).permit(:value, :birthdate, :term_in_months, :user_id)
    end
end
