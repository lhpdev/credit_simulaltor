class ProcessSimulationJob < ApplicationJob
  queue_as :default

  def perform(simulation_id)
    simulation = Simulation.find_by(id: simulation_id)
    return unless simulation

    CreditSimulationService.new(
      loan_value: simulation.value,
      birthdate: simulation.birthdate,
      term_in_months: simulation.term_in_months,
      user_id: simulation.user_id,
      simulation_id: simulation.id
    ).call
  end
end
