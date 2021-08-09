require 'rails_helper'
require_relative '../../../create_test_objects.rb'
RSpec.describe 'merchant discount index page' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data
    @merchant = Merchant.first
    @discount1 = @merchant.discounts.create(percent_off:10 ,quantity:5 )
    @discount2 = @merchant.discounts.create(percent_off:20 ,quantity:10 )
    @discount3 = @merchant.discounts.create(percent_off:30 ,quantity:8 )
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

    expect(page).to have_link("SAVE#{@discount1.percent_off.to_i}ON#{@discount1.quantity}")
    expect(page).to have_link("SAVE#{@discount2.percent_off.to_i}ON#{@discount2.quantity}")
    expect(page).to have_link("SAVE#{@discount3.percent_off.to_i}ON#{@discount3.quantity}")
    click_on("SAVE#{@discount1.percent_off.to_i}ON#{@discount1.quantity}")
    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@discount1.id}")
  end

  #   When I visit the discounts index page
  # I see a section with a header of "Upcoming Holidays"
  # In this section the name and date of the next 3 upcoming US holidays are listed.

  # Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
  describe 'Upcoming Holidays' do
    it 'has the names and dates of the next 3 US holidays' do
      within "#upcoming_holidays" do
        
        expect(page).to have_content()
      end
    end
  end
  #   As a merchant
  # When I visit my bulk discounts index
  # Then I see a link to create a new discount

  it 'has a link to create a new discount' do
    expect(page).to have_link("create discount")
  end
  # When I click this link
  # Then I am taken to a new page where I see a form to add a new bulk discount
  # When I fill in the form with valid data
  # Then I am redirected back to the bulk discount index
  # And I see my new bulk discount listed
  it 'after creating new discount, redirected to index and new discount is shown' do
    click_link("create discount")
    fill_in 'percent_off', with: '5'
    fill_in 'quantity', with: '3'
    click_on("commit")
    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
    expect(page).to have_content("SAVE5ON3")
  end

  #   As a merchant
  # When I visit my bulk discounts index
  # Then next to each bulk discount I see a link to delete it
  # When I click this link
  # Then I am redirected back to the bulk discounts index page
  # And I no longer see the discount listed
  it 'can delete a discount and remove it from merchants discounts' do
    within("#discount#{@discount1.id}") do
      click_link("delete discount")
    end
    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
    expect(page).to_not have_content(@discount1.percent_off)
  end
end