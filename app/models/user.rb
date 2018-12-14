class User < ApplicationRecord
  has_secure_password
  has_secure_token :token_reset
  has_one :entity, as: :entityable, dependent: :destroy
  accepts_nested_attributes_for :entity
  attr_accessor :password_current, :require_password_current, :new_password, :new_password_confirmation

  default_scope { where(deleted: false) }
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, :password_confirmation, length: { in: 6..20 }, allow_blank: true

  validates :password_current, presence: true, if: :require_password_current
  validate :password_current_verify, if: :require_password_current
  after_validation :update_passowrd, if: :require_password_current

  before_create :generate_token

  private

  def password_current_verify
    errors.add(:password_current, 'Password is incorrect') unless authenticate(password_current)
  end

  def update_passowrd
    errors.add(:new_password_confirmation, 'Password is different') if new_password != new_password_confirmation
    self.password = new_password if new_password.present?
  end

  def generate_token
    self.token_reset = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Admin.exists?(token_reset: random_token)
    end
  end
end
