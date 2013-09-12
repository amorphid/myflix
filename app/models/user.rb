class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password_digest, presence: true
end
