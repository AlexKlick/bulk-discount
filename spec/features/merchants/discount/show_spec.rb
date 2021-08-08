require 'rails_helper'

RSpec.describe 'merchant discount show' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data
    @merchant = Merchant.first
    @discount1 = Discount.create(percent_off:10 ,quantity:5 , merchant_id: @merchant)
    @discount2 = Discount.create(percent_off:20 ,quantity:10 , merchant_id: @merchant)
    @discount3 = Discount.create(percent_off:30 ,quantity:8 , merchant_id: @merchant)
    visit "/merchants/#{@merchant.id}/discounts/#{@discount1.id}"
  end
#   As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount
  it 'has the discounts attrs' do
    expect(page).to have_content(@discount1.percent_off)
    expect(page).to have_content(@discount1.quantity)
  end

#   As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount


end