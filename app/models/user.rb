class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :trackable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  def admin?
    CoreUIsettings.admin.emails.include?(email)
  end
end
