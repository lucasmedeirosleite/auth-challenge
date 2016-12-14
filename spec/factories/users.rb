FactoryGirl.define do
  factory(:user) do
    sequence(:email)    { |i| "email_#{i}@example.com" }
    sequence(:password) { |i| "password#{i}" }
    sequence(:password_confirmation) { |i| "password#{i}" }
  end
end
