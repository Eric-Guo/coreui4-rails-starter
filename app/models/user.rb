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

  def role_ids
    @_role_ids ||= user_roles.collect(&:role_id)
  end

  def role_ids=(values)
    select_values = Array(values).reject(&:blank?).map(&:to_i)
    if new_record?
      (select_values - role_ids).each do |to_new_id|
        user_roles.build(role_id: to_new_id)
      end
    else
      (role_ids - select_values).each do |to_destroy_id|
        user_roles.find_by(role_id: to_destroy_id).destroy
      end
      (select_values - role_ids).each do |to_add_id|
        user_roles.create(role_id: to_add_id)
      end
    end
  end
end
