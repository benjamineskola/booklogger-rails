FactoryBot.define do
  factory :author, aliases: [:first_author] do
    forenames { Faker::Name.first_name + " " + Faker::Name.middle_name }
    surname { Faker::Name.last_name }
  end

  factory :book do
    title { Faker::Book.title }
    first_author
  end
end
