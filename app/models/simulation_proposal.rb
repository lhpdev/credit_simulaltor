class SimulationProposal
  include Mongoid::Document
  include Mongoid::Timestamps

  field :valid_proposal, type: Boolean, default: true
  field :expired_at, type: DateTime, default: nil

  # Callbacks
  before_save :set_expiration, if: :valid_proposal_changed?

  field :user_id, type: Integer
  field :simulation_id, type: Integer

  field :total_amount, type: Float
  field :monthly_payment, type: Float
  field :total_fees, type: Float

  def self.active
    where(valid_proposal: true)
  end

  private

  def set_expiration
    if expired_at.nil? && valid_proposal == true
      self.expired_at = Time.now + 1.month
    elsif expired_at.present?
      self.valid_proposal = false
    end
  end
end
