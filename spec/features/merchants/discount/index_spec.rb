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

  #   When I visit the discounts index page
  # I see a section with a header of "Upcoming Holidays"
  # In this section the name and date of the next 3 upcoming US holidays are listed.

  # Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
  describe 'Upcoming Holidays' do
    it 'has the names and dates of the next 3 US holidays' do

    end
  end
end