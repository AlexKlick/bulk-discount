class Invoice < ApplicationRecord
  enum status: { "in progress": 0, cancelled: 1, completed: 2 }

  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :status, presence: true

  scope :sort_oldest, -> { order('created_at asc') }

  def self.incomplete_invoices
    joins(:invoice_items)
      .where.not(invoice_items: { status: :shipped })
      .distinct
  end

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def invoice_total_revenue
    invoice_items.where('invoice_items.invoice_id = ?', id)
                 .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def discounted_revenue
    self.create_invoice_discounts
    self.invoice_items
        .left_outer_joins(:discount)
        .select("CASE WHEN discounts.percent_off > 0 
        THEN  (100 - discounts.percent_off) / 100 * invoice_items.quantity * invoice_items.unit_price 
        ELSE invoice_items.quantity * invoice_items.unit_price 
        END AS revenue")
        .sum do |r|
          r.revenue
        end
  end

  def create_invoice_discounts
    invoice_items.each do |item|
      best_discount = self.invoice_items 
                          .joins(item: {merchant: :discounts})
                          .select('discounts.id AS discount_id')
                          .where('discounts.quantity <= ?', item.quantity)
                          .order('discounts.percent_off desc')
                          .first
      if best_discount
        if DiscountInventory.where(discount_id: best_discount.discount_id, invoice_item_id: item.id) != []
          di = DiscountInventory.where(discount_id: best_discount.discount_id, invoice_item_id: item.id).first
          DiscountInventory.destroy(di.id)
        end
        discount_inventory = DiscountInventory.create!(discount_id: best_discount.discount_id, invoice_item_id: item.id)
      end
    end
  end
end
