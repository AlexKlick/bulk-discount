require 'rails_helper'
require_relative '../../../create_test_objects.rb'
RSpec.describe 'merchant discount index page' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data
    @merchant = Merchant.first
    @discount1 = Discount.create(percent_off:10 ,quantity:5 , merchant_id: @merchant)
    @discount2 = Discount.create(percent_off:20 ,quantity:10 , merchant_id: @merchant)
    @discount3 = Discount.create(percent_off:30 ,quantity:8 , merchant_id: @merchant)
    visit "/merchants/#{@merchant.id}/discounts"
  end

  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page
  it 'has all of the bulk discounts attrs' do
    expect(page).to have_content(@discount1.percent_off)
    expect(page).to have_content(@discount2.percent_off)
    expect(page).to have_content(@discount3.percent_off)
    expect(page).to have_content(@discount1.quantity)
    expect(page).to have_content(@discount2.quantity)
    expect(page).to have_content(@discount3.quantity)

  end

  it 'has a link to each discounts show page' do
    expect(page).to have_link("#{@discount1.percent_off}OFF#{@discount1.quantity}")
    expect(page).to have_link("#{@discount2.percent_off}OFF#{@discount2.quantity}")
    expect(page).to have_link("#{@discount3.percent_off}OFF#{@discount3.quantity}")
  end

  
end