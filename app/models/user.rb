class User < ApplicationRecord
  USER_PARAMS = %i(user_name email full_name password password_confirmation)
                .freeze

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :tours
  has_many :likes, dependent: :destroy

  before_save{email.downcase!}
  validates :user_name, presence: true, length: {maximum: Settings.username}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum:
    Settings.password}, allow_nil: true
  validates :role, presence: true

  enum role: [:admin, :user]

  scope :newest, ->{order created_at: :desc}

  class << self
    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end
end
