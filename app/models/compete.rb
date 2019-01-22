class Compete < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  scope :publication_scope, ->(publication) { where(publication_id: publication.id) }
end
