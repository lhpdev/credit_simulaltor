FactoryBot.define do
  factory :simulation_proposal do
    total_amount { 11_000 }
    monthly_payment { 458.33 }
    total_fees { 1_000 }
    valid_proposal { true }
  end
end