class CreateAjaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :ajaxes do |t|
      t.string :content

      t.timestamps
    end
  end
end
