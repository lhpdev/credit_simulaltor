FactoryBot.define do
  factory :simulation do
    birthdate { "1990-12-13" }
    term_in_months { 10 }
    value { 10000 }

    association :user
  end
end
