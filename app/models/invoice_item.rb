class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  belongs_to :invoice
  belongs_to :item

  has_one :discount_inventory
  has_one :discount, through: :discount_inventory

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  def self.oldest_to_newest
    order(created_at: :desc)
  end

  def item_name
    item.name
  end
end
