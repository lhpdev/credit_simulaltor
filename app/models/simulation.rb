class Simulation < ApplicationRecord
  # Validations
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :birthdate, presence: true
  validates :term_in_months, presence: true, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :user

  def active_proposals
    proposals.active
  end

  def proposals
    SimulationProposal.where(simulation_id: id)
  end
end
