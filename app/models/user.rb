class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :reviews

  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :email,           presence: true, uniqueness: {case_sensitive: false}
  validates :password,        presence: true, length: {minimum: 8}
  validates :password_digest, presence: true
  def self.authenticate_with_credentials(email, password)
    email_stripped_downcase = email.strip.downcase
    user = User.where("email = ?", email_stripped_downcase).first
    if user && user.authenticate(password)
      user
    else
     nil
    end
  end
end
