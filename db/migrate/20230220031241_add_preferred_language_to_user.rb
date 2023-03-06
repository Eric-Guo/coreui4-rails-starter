class AddPreferredLanguageToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :preferred_language, :string
    add_column :users, :preferred_page_length, :integer, default: 10, null: false
  end
end
