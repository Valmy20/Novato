class Post < ApplicationRecord
  has_many :ass_post_categories, dependent: :destroy
  has_many :categories, through: :ass_post_categories
  validates :title, length: { in: 2..100 }, presence: true
  validates :body, length: { minimum: 200 }, presence: true
  default_scope { where(deleted: false) }
  enum status: %i[disapproved approved review]
  scope :collaborator, ->(collaborator) { where(postable_type: 'Collaborator', postable_id: collaborator.id) }

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :thumb, ThumbUploader
  after_update :crop_thumb

  extend FriendlyId
  friendly_id :title, use: :slugged
  before_validation :allow_category_ids

  private

  def crop_thumb
    thumb.recreate_versions! if crop_x.present?
  end

  def allow_category_ids
    ids = category_ids
    new_ids = []
    ids.each do |id|
      new_ids.push(id) if Category.where(id: id, status: true).exists?
    end
    self.category_ids = new_ids
  end
end
