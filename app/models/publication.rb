class Publication < ApplicationRecord
  require 'i18n'
  belongs_to :publicationable, polymorphic: true

  extend FriendlyId
  friendly_id :title, use: :slugged
  before_save :save_title_without_accents

  default_scope { where(deleted: false) }
  scope :employer, ->(employer) { where(publicationable_type: 'Employer', publicationable_id: employer.id) }
  scope :institution, ->(institution) { where(publicationable_type: 'Institution', publicationable_id: institution.id) }
  scope :available_publication, -> { where(status: :approved, visibility: true) }
  scope :filter_job_posts, -> { where(_type: :emprego) }
  scope :filter_internship_posts, -> { where(_type: :estagio) }
  enum _type: %i[estagio emprego]
  enum status: %i[disapproved approved review]
  validates :title, length: { in: 4..100 }, presence: true
  validates :vacancies, presence: true, numericality: { greater_than: 0 }
  validates :_type, presence: true
  validates :remunaration, numericality: { greater_than: 0 }, allow_blank: true
  validates :information, length: { minimum: 100 }, presence: true

  def place_pin
    location.tr('()', '') if location.present?
  end

  private

  def save_title_without_accents
    self.title_for_search = I18n.transliterate(title)
  end
end
