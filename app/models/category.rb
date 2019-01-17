class Category < ApplicationRecord
  belongs_to :admin
  has_many :ass_post_categories, dependent: :destroy
  has_many :posts, through: :ass_post_categories
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, length: { in: 2..20 }
  default_scope { where(deleted: false) }
end
