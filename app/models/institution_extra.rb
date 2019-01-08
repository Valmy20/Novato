class InstitutionExtra < ApplicationRecord
  belongs_to :institution
  validates :about, length: { in: 10..500 }, allow_blank: true

  def place_pin
    location.tr('()', '') if location.present?
  end
end
