class ChangeColumnEmotionToReacts < ActiveRecord::Migration[7.0]
  def change
    change_column(:reacts, :emotion, :integer)
  end
end
