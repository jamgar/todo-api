FactoryGirl.define do
  factory :notes do
    content { Faker::StarWars.character }
    #done false
    card_id nil
  end
end

