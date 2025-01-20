FactoryBot.define do
  factory :user do
    email_address { "email#{rand(1000..9999)}@user.com" }
    password { "123456" }
  end
end
