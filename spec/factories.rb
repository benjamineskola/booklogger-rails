FactoryBot.define do
  factory :author, aliases: [:first_author] do
    forenames { Faker::Name.first_name + " " + Faker::Name.middle_name }
    surname { Faker::Name.last_name }
  end

  factory :primary_edition, aliases: [:book] do
    title { Faker::Book.title }
    first_author
    isbn { Faker::Code.isbn }
  end

  factory :edition do
    primary_edition
    isbn { Faker::Code.isbn }
  end
end
