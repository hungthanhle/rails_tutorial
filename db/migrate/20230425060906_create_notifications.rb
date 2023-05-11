class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :notification_with_id
      t.integer :notice_type
      t.boolean :read, default: false
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
