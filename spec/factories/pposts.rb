FactoryGirl.define do
  factory :ppost do
    title { Faker::Lorem.word }
    user
  end
end