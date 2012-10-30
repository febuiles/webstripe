class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stripes

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username

  def admin?
    role == "admin"
  end
end
