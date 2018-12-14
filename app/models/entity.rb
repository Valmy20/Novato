class Entity < ApplicationRecord
  belongs_to :entityable, polymorphic: true

  validates :name, presence: true, length: { in: 2..30 }
  validates :email, presence: true, email: true, uniqueness: {
    scope: :deleted, conditions: -> { where(deleted: false) }
  }

  before_create :save_email_downcase

  private

  def save_email_downcase
    self.email = email.downcase
  end
end
