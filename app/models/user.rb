class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :posts

  def signed_in?
    email != "Guest"
  end
end
