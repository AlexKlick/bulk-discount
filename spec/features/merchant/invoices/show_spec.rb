require 'rails_helper'

RSpec.describe 'merchant invoices index page' do
  before :each do
    #merchants
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    #items
    @item1 = create(:item, enabled: true, merchant: @merchant1)
    @item2 = create(:item, enabled: true, merchant: @merchant1)
    @item3 = create(:item, enabled: true, merchant: @merchant1)
    @item4 = create(:item, enabled: true, merchant: @merchant2)

    #customers
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    #invoices
    @invoice1 = create(:invoice, :"in progress", customer: @customer1)
    @invoice2 = create(:invoice, :"in progress", customer: @customer1)
    @invoice3 = create(:invoice, :"in progress", customer: @customer1)
    @invoice4 = create(:invoice, :cancelled, customer: @customer2)

    #invoice_items
    @invoice_item1 = create(:invoice_item, :pending, invoice: @invoice1, item: @item1)
    @invoice_item2 = create(:invoice_item, :pending, invoice: @invoice1, item: @item2)
    @invoice_item3 = create(:invoice_item, :packaged, invoice: @invoice3, item: @item3)
    @invoice_item4 = create(:invoice_item, :pending, invoice: @invoice4, item: @item4)
  end

  it 'displays the merchant invoice show page and its attributes' do
    # Merchant Invoice Show Page
    #
    # As a merchant
    # When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
    # Then I see information related to that invoice including:
    # - Invoice id
    # - Invoice status
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    # - Customer first and last name
    visit("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")

    expect(page).to have_content("Little Esty Shop")
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    #do we need to change lower case 'in progress' to 'In Progress' here?
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %-d, %Y")}")
    expect(page).to have_content("Customer:")
    expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
  end

  xit 'displays all invoice items and their attributes' do
    # Merchant Invoice Show Page: Invoice Item Information
    #
    # As a merchant
    # When I visit my merchant invoice show page
    # Then I see all of my items on the invoice including:
    # - Item name
    # - The quantity of the item ordered
    # - The price the Item sold for
    # - The Invoice Item status
    # And I do not see any information related to Items for other merchants
    visit("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")

    save_and_open_page
    within("#item_#{@item1.id}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.unit_price)
      expect(page).to have_content(@invoice_item1.status)
    end

    within("#item_#{@item2.id}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@invoice_item2.quantity)
      expect(page).to have_content(@invoice_item2.unit_price)
      expect(page).to have_content(@invoice_item2.status)
    end

    expect(page).to_not have_content(@item3.name)
  end
end
