class Employer < ApplicationRecord
  has_secure_password
  has_secure_token :token_reset
  has_one :employer_extra, dependent: :destroy
  accepts_nested_attributes_for :employer_extra
  attr_accessor :password_current, :require_password_current, :new_password,
                :new_password_confirmation

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :logo, LogoUploader
  after_update :crop_logo

  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { where(deleted: false) }
  enum status: %i[disapproved approved]
  validates :name, presence: true, length: { in: 2..50 }
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, :password_confirmation, length: { in: 6..20 }, allow_blank: true
  validates :email, presence: true, email: true, uniqueness: {
    scope: :deleted, conditions: -> { where(deleted: false) }
  }

  validates :password_current, presence: true, if: :require_password_current
  validate :password_current_verify, if: :require_password_current
  after_validation :update_passowrd, if: :require_password_current

  before_create :generate_token

  def crop_logo
    logo.recreate_versions! if crop_x.present?
  end

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
      break random_token unless Employer.exists?(token_reset: random_token)
    end
  end
end
