class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.float :percent_off
      t.integer :quantity

      t.timestamps
    end
  end
end
