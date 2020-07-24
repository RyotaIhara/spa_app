class User < ApplicationRecord
  GENDERS = { 男: true, 女: false }

  enum gender: GENDERS

  validates :gender, inclusion: { in: GENDERS.keys.concat(GENDERS.keys.map(&:to_s)) }, exclusion: { in: [nil] }
  validates :name, exclusion: { in: [nil, ""] }
  validates :age, exclusion: { in: [nil] }
end
