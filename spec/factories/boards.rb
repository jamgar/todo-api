FactoryGirl.define do
  factory :board do
    title { Faker::Lorem.word }
    user_id nil
  end
end
