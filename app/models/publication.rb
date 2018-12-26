class Publication < ApplicationRecord
  belongs_to :publicationable, polymorphic: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope { where(deleted: false) }
  scope :employer, ->(employer) { where(publicationable_type: 'Employer', publicationable_id: employer.id) }
  enum _type: %i[estagio emprego]
  validates :title, length: { in: 4..100 }, presence: true
  validates :vacancies, presence: true
  validates :information, length: { in: 10..700 }, allow_blank: true

  def place_pin
    location.tr('()', '') if location.present?
  end
end
