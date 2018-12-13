class Category < ApplicationRecord
  belongs_to :admin

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, length: { in: 2..20 }
  default_scope { where(deleted: false) }
end
