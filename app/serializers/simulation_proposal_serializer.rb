class SimulationSerializer < ActiveModel::Serializer
  attributes :_id, :monthly_payment, :simulation_id, :total_amount, :total_fees, :created_at, :updated_at, :valid_proposal, :user_id
end
