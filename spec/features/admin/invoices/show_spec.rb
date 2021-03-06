require 'rails_helper'
require_relative '../../../create_test_objects.rb'

RSpec.describe 'Admin invoice Show page' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data
    @invoice = Invoice.first
    visit "/admin/invoices/#{@invoice.id}"
  end

  # Then I see information related to that invoice including:
  # - Invoice id
  # - Invoice status
  # - Invoice created_at date in the format "Monday, July 18, 2019"
  # - Customer first and last name
  it 'has the invoices attributes' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.formatted_time)
    expect(page).to have_content(@invoice.customer.first_name)
    expect(page).to have_content(@invoice.customer.last_name)
  end

  # When I visit an admin invoice show page
  # Then I see all of the items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status
  it 'has the attrs for all of the items on the invoice and the invoice items status' do
    within("table#items") do
      within("tr##{@invoice.invoice_items[0].id}") do
        expect(page).to have_content(@invoice.invoice_items[0].item_name)
        expect(page).to have_content(@invoice.invoice_items[0].quantity)
        expect(page).to have_content(@invoice.invoice_items[0].unit_price.to_f / 100)
        expect(page).to have_content(@invoice.invoice_items[0].status)
      end

      within("tr##{@invoice.invoice_items[1].id}") do
        expect(page).to have_content(@invoice.invoice_items[1].item_name)
        expect(page).to have_content(@invoice.invoice_items[1].quantity)
        expect(page).to have_content(@invoice.invoice_items[1].unit_price.to_f / 100)
        expect(page).to have_content(@invoice.invoice_items[1].status)
      end

      within("tr##{@invoice.invoice_items[2].id}") do
        expect(page).to have_content(@invoice.invoice_items[2].item_name)
        expect(page).to have_content(@invoice.invoice_items[2].quantity)
        expect(page).to have_content(@invoice.invoice_items[2].unit_price.to_f / 100)
        expect(page).to have_content(@invoice.invoice_items[2].status)
      end
    end
  end

  # When I visit an admin invoice show page
  # Then I see the total revenue that will be generated from this invoice
  it 'shows the total revenue for the invoice' do
    within("h4#total_revenue") do
      revenue = (8363 * 11 + 1177 * 9 + 4960 * 15).to_f / 100
      expect(page).to have_content("Total Revenue: $#{revenue}")
    end
  end

  # I see the invoice status is a select field
  # And I see that the invoice's current status is selected
  # When I click this select field,
  # Then I can select a new status for the Invoice,
  # And next to the select field I see a button to "Update Invoice Status"
  # When I click this button
  # I am taken back to the admin invoice show page
  # And I see that my Invoice's status has now been updated

  it 'has a select field to change the invoice status, which updates status and returns to invoice show page' do
    # visit "/admin/invoices/#{@invoice.id}"
    # expect(first('.status').text[0..7]).to include 'packaged'
    # first('.status').click_button
    # within(first('.dropdown-menu')) do
    #   click_link('shipped')
    # end
    # expect(first('.status').text[0..6]).to include 'shipped'
  end

  #   As an admin
  # When I visit an admin invoice show page
  # Then I see the total revenue from this invoice (not including discounts)
  # And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
  it 'has the discounted revenue for the invoice' do
    @merchant = @invoice.merchants.first
    @discount1 = @merchant.discounts.create(percent_off:10 ,quantity:5 )
    @discount2 = @merchant.discounts.create(percent_off:20 ,quantity:10 )
    @discount3 = @merchant.discounts.create(percent_off:30 ,quantity:8 )
    
    visit "/admin/invoices/#{@invoice.id}"
    expect(page).to have_content("discounted revenue: $1,238.90")
  end
end
