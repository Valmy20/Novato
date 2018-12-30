class Skill < ApplicationRecord
  belongs_to :user

  validates :name, length: { in: 0..27 }
end
