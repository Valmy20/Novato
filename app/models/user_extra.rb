class UserExtra < ApplicationRecord
  belongs_to :user

  validates :bio, length: { in: 10..200 }, allow_blank: true
end
