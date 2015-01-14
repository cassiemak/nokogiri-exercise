class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :name
      t.string :img_url
      t.string :details

      t.timestamps
    end
  end
end
