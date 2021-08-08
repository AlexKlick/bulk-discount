class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :discount_inventories
  has_many :invoice_items, through: :discount_inventory


  validates :quantity, presence: true, numericality: true
  validates :percent_off, presence: true, numericality: true
  validates :merchant_id, presence: true
end