class CreateDiscountInventory < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_inventories do |t|
      t.references :invoice_item, foreign_key: true
      t.references :discount, foreign_key: true

      t.timestamps
    end
  end
end
