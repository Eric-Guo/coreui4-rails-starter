class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  def user_ids
    @_user_ids ||= user_roles.collect(&:user_id)
  end

  def user_ids=(values)
    select_values = Array(values).reject(&:blank?).map(&:to_i)
    if new_record?
      (select_values - user_ids).each do |to_new_id|
        user_roles.build(user_id: to_new_id)
      end
    else
      (user_ids - select_values).each do |to_destroy_id|
        user_roles.find_by(user_id: to_destroy_id).destroy
      end
      (select_values - user_ids).each do |to_add_id|
        user_roles.create(user_id: to_add_id)
      end
    end
  end
end
