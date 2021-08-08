class DiscountInventory < ApplicationRecord
  belongs_to :discount
  belongs_to :invoice_item

  validates :discount_id, presence: true
  validates :invoice_item_id, presence: true
end