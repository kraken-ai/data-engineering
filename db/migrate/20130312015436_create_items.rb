class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :id
      t.string :description
      t.float :price
      t.integer :merchant_id

      t.timestamps
    end
  end
end
