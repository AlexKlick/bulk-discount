require 'rails_helper'
require_relative '../../../create_test_objects.rb'
RSpec.describe 'merchant discount show' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data
    @merchant = Merchant.first
    @discount1 = Discount.create(percent_off:10 ,quantity:5 , merchant_id: @merchant.id)
    @discount2 = Discount.create(percent_off:20 ,quantity:10 , merchant_id: @merchant.id)
    @discount3 = Discount.create(percent_off:30 ,quantity:8 , merchant_id: @merchant.id)
    visit "/merchants/#{@merchant.id}/discounts/#{@discount1.id}"
  end
#   As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount
  it 'has the discounts attrs' do
    expect(page).to have_content(@discount1.percent_off.to_i)
    expect(page).to have_content(@discount1.quantity)
  end

  #   As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  it 'has a link to edit' do
    click_on('edit')
    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}/edit")
  end

end