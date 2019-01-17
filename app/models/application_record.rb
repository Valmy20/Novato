class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :published, -> { where(deleted: false, status: true) }
end
