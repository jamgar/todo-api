FactoryGirl.define do
  factory :card do
    title { Faker::Lorem.word }
    board_id nil
  end
end
