class AddContentToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :content, :string
  end
end
