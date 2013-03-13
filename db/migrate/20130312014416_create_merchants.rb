class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.integer :id
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
