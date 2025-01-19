class SimulationSerializer < ActiveModel::Serializer
  attributes :id, :value, :birthdate, :term_in_months, :user_id, :created_at, :updated_at, :proposals

  def proposals
    [
      local: @object.active_proposals,
      bank_2: [],
      bank_3: []
    ]
  end
end
