require 'rails_helper'
require_relative '../create_test_objects.rb'
RSpec.describe Discount do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:discount_inventories) }
  end

  describe 'class methods' do

  end
  describe 'instance methods' do
    describe 'discount_code' do
      it 'returns the discount code for the discount' do
        TestData.create_all_data
        @merchant = Merchant.first
        @discount1 = Discount.create!(percent_off:10 ,quantity:5 , merchant_id: @merchant.id)
        expect(@discount1.discount_code).to eq("SAVE10ON5")
      end
    end
  end
end