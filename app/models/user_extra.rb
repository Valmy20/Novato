class UserExtra < ApplicationRecord
  belongs_to :user

  validates :bio, length: { in: 10..500 }, allow_blank: true
end
