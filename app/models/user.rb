class User < ApplicationRecord
  has_secure_password
  has_secure_token :token_reset
  has_one :user_extra, dependent: :destroy
  has_many :skills, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :skills, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :user_extra, allow_destroy: true
  attr_accessor :password_current, :require_password_current, :new_password,
                :new_password_confirmation, :skip_password, :require_user_cover

  attr_accessor :cropc_x, :cropc_y, :cropc_w, :cropc_h
  mount_uploader :cover, CoverUploader
  after_update :crop_cover

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :avatar, AvatarUploader
  after_update :crop_avatar

  extend FriendlyId
  friendly_id :name, use: :slugged
  default_scope { where(deleted: false) }

  enum status: %i[disapproved approved]
  validates :cover, presence: true, if: :require_user_cover
  validates :name, presence: true, length: { in: 2..50 }
  validates :password, :password_confirmation, presence: true, on: :create, unless: :skip_password
  validates :password, :password_confirmation, length: { in: 6..20 }, allow_blank: true
  validates :email, presence: true, email: true, uniqueness: {
    scope: :deleted, conditions: -> { where(deleted: false) }
  }

  validates :password_current, presence: true, if: :require_password_current
  validate :password_current_verify, if: :require_password_current
  after_validation :update_passowrd, if: :require_password_current

  before_create :generate_token

  def self.create_from_auth_hash(auth:)
    user = User.where(uid: auth.uid, provider: auth.provider).last
    unless user
      email = auth.info.email
      user = User.new
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = email || "#{auth.uid}@#{auth.provider}.com"
      user.credentials = auth.credentials
      user.skip_password = true
      user.password = SecureRandom.alphanumeric(10)
      user.status = 0
      user.save
    end
    user
  end

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def crop_cover
    cover.recreate_versions! if cropc_x.present?
  end

  def self.search(search)
    q = "%#{search}%"
    where('name ILIKE :search', search: q)
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
      break random_token unless User.exists?(token_reset: random_token)
    end
  end
end
