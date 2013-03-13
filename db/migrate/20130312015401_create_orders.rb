class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :id
      t.integer :item_id
      t.integer :item_count
      t.integer :company_id
      t.integer :purchaser_id

      t.timestamps
    end
  end
end
