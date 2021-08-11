require 'rails_helper'
require_relative '../../../create_test_objects.rb'

RSpec.describe 'merchants discount edit page' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data
    @merchant = Merchant.first
    @discount1 = Discount.create!(percent_off:10 ,quantity:5 , merchant_id: @merchant.id)
    @discount2 = Discount.create!(percent_off:20 ,quantity:10 , merchant_id: @merchant.id)
    @discount3 = Discount.create!(percent_off:30 ,quantity:8 , merchant_id: @merchant.id)
    visit "/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit"
  end
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated
  it 'allows user to edit the discount, upon submission, returns to show page where attributes are updated' do
    expect(find('#discount_percent_off').value).to eq("10.0")
    expect(find('#discount_quantity').value).to eq("5")
    fill_in 'discount_percent_off', with: '100'
    fill_in 'discount_quantity', with: '26'
    click_on("commit")
    expect(page).to have_content("SAVE100ON26")
    expect(page).to have_content("100")
    expect(page).to have_content("26")
  end
end