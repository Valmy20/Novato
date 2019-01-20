class Publication < ApplicationRecord
  belongs_to :publicationable, polymorphic: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope { where(deleted: false) }
  scope :employer, ->(employer) { where(publicationable_type: 'Employer', publicationable_id: employer.id) }
  scope :institution, ->(institution) { where(publicationable_type: 'Institution', publicationable_id: institution.id) }
  enum _type: %i[estagio emprego]
  validates :title, length: { in: 4..100 }, presence: true
  validates :vacancies, presence: true, numericality: { greater_than: 0 }
  validates :_type, presence: true
  validates :remunaration, numericality: { greater_than: 0 }, allow_blank: true
  validates :information, length: { minimum: 200, maximum: 780 }, presence: true

  def place_pin
    location.tr('()', '') if location.present?
  end
end
