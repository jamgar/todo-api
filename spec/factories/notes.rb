FactoryGirl.define do
  factory :note do
    content { Faker::StarWars.character }
    card_id nil
  end
end

