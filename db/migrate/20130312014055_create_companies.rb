class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :id
      t.string :open_id

      t.timestamps
    end
  end
end
