class AddSidebarNarrowToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :sidebar_narrow, :boolean, null: false, default: false
  end
end
