class Invoice < ApplicationRecord
  enum status: { "in progress": 0, cancelled: 1, completed: 2 }

  belongs_to :customer
  
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  validates :status, presence: true

  def items_belonging_to
    invoice_items.select('invoice_items.status, items.*').joins(:item)
  end
end
