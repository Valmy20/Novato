class Skill < ApplicationRecord
  require 'i18n'
  belongs_to :user

  validates :name, length: { in: 0..27 }
  before_save :save_name_without_accents

  private

  def save_name_without_accents
    self.name_for_search = I18n.transliterate(name)
  end
end
