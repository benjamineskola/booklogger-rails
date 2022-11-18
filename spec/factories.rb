FactoryBot.define do
  factory :author do
    forenames { Faker::Name.first_name + " " + Faker::Name.middle_name }
    surname { Faker::Name.last_name }
  end

  factory :book do
    title { Faker::Faker::Book.title }
  end
end
