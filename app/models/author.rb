class Author < ApplicationRecord
  enum gender: {
    unknown: 0,
    male: 1,
    female: 2,
    organization: 3,
    nonbinary: 4
  }
end
