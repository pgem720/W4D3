class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  after_initialize :reset_session_token!

  has_many :cats,
  foreign_key: :user_id,
  class_name: :Cat

  attr_reader :password
  def reset_session_token!
    session_token = SecureRandom::urlsafe_base64
    save!
    session_token
  end

  def password=(password)
    @password = password
    password_digest = BCrypt::Password.create(password)  
  end

  def is_password?(password)
    crypt_pw = BCrypt::Password.new(password_digest)
    crypt_pw.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = self.class.find_by(username: username)
    return nil unless user && user.is_password?(password)
  end

end