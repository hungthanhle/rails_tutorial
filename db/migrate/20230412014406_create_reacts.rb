class CreateReacts < ActiveRecord::Migration[7.0]
  def change
    create_table :reacts do |t|
      t.text :emotion
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true

      t.timestamps
    end
  end
end
