class User < ApplicationRecord
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank'}
  validates :password, length: { minimum: 6, allow_nil: true,
    message: "must be at least 6 characters long!"
  }
  before_validation :ensure_session_token

  attr_reader :password

  # def is_password?(password)
  #   BCrpyt::Password.new(self.password_digest).is_password?(password)
  # end

  has_many :cats,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Cat

  has_many :requests,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :CatRentalRequest

  has_many :sessions,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Session

  def self.find_by_credentials(username, password)
    user = User.find_by(user_name: username)
    return user if user && BCrypt::Password.new(user.password_digest).is_password?(password)
    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
