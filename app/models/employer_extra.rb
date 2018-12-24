class EmployerExtra < ApplicationRecord
  belongs_to :employer
  validates :about, length: { in: 10..500 }, allow_blank: true

  def place_pin
    location.tr('()', '') if location.present?
  end
end
