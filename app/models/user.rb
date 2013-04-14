class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stripes
  validates :username, presence: true, uniqueness: true
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username

  scope :admin, where(role: "admin")
  scope :basic, where(role: "basic")
  scope :pro, where(role: "pro")

  def admin?
    role == "admin"
  end

  def accepted_invitation?
    invitation_accepted_at.present?
  end

end
