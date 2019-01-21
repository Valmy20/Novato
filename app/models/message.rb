class Message < ApplicationRecord
  validates :body, presence: true, length: { in: 2..500 }
  validates :email, presence: true, email: true, uniqueness: {
    scope: :deleted, conditions: -> { where(deleted: false) }
  }
  default_scope { where(deleted: false) }
end
