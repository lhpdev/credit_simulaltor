class SimulationsController < ApplicationController
  before_action :set_simulation, only: %i[ show ]
  allow_unauthenticated_access

  # GET /simulations or /simulations.json
  def index
    @simulations = Simulation.all
    respond_to do |format|
      format.json { render json: @simulations, status: :ok }
    end
  end

  # GET /simulations/1 or /simulations/1.json
  def show
    @user_age = helpers.calculate_age(@simulation.birthdate)
    respond_to do |format|
      format.json { render json: @simulation, status: :ok }
    end
  end

  # GET /simulations/new
  def new
    @simulation = Simulation.new
  end

  # GET /simulations/1/edit
  def edit
  end

  # POST /simulations or /simulations.json
  # def create
  #   @simulation = Simulation.new(simulation_params)
  #   respond_to do |format|
  #     if @simulation.save
  #       # Extract this to be run in a background job in paralell
  #       CreditSimulationService.new(
  #         loan_value: @simulation.value,
  #         birthdate: @simulation.birthdate,
  #         term_in_months: @simulation.term_in_months,
  #         user_id: @simulation.user_id,
  #         simulation_id: @simulation.id
  #       ).call

  #       # format.html { redirect_to @simulation, notice: "Simulation was successfully created." }
  #       format.json { render :json @simulation, notice: "Simulation was successfully created.", serializer: SimulationSerializer }
  #     else
  #       # format.html { render :new, status: :unprocessable_entity }
  #       render json: { error: 'Simulation could not be created' }, status: :unprocessable_entity
  #     end
  #   end
  # end

  # PATCH/PUT /simulations/1 or /simulations/1.json
  # def update
  #   respond_to do |format|
  #     if @simulation.update(simulation_params)
  #       format.html { redirect_to @simulation, notice: "Simulation was successfully updated." }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Simulation not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def simulation_params
    params.require(:simulation).permit(:value, :birthdate, :term_in_months, :user_id)
  end
end
