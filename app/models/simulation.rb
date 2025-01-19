class Simulation < ApplicationRecord
  # Validations
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :birthdate, presence: true
  validates :term_in_months, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  # Callbacks
  before_validation :ensure_attributes_present

  belongs_to :user

  def active_proposals
    SimulationProposal.where(simulation_id: id).active.to_a
  end

  private

  # Callback to ensure attributes are present before validation
  def ensure_attributes_present
    errors.add(:value, "can't be blank") if value.nil?
    errors.add(:birthdate, "can't be blank") if birthdate.nil?
    errors.add(:term_in_months, "can't be blank") if term_in_months.nil?
  end
end
