class AddMicropostIdToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :micropost_id, :integer
  end
end
