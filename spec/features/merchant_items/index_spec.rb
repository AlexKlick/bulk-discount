require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant1 = create(:merchant, enabled: true)
    @merchant2 = create(:merchant, enabled: true)

    @item1 = create(:item, enabled: true, merchant: @merchant1)
    @item2 = create(:item, enabled: true, merchant: @merchant1)
    @item3 = create(:item, enabled: false, merchant: @merchant1)
    @item4 = create(:item, enabled: true, merchant: @merchant2)
    @item5 = create(:item, enabled: false, merchant: @merchant2)
    @item6 = create(:item, enabled: true, merchant: @merchant1)
    @item7 = create(:item, enabled: true, merchant: @merchant1)
    @item8 = create(:item, enabled: true, merchant: @merchant2)

    @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')
    @customer2 = Customer.create!(first_name: 'Donkey', last_name: 'Kong')

    @invoice1 = @customer1.invoices.create!(status: 0) # in progress
    @invoice2 = @customer2.invoices.create!(status: 0) # in progress
    @invoice3 = @customer2.invoices.create!(status: 2) # completed

    # @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 216, status: 0) # pending
    # @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 400, status: 1) # packaged
    @invoice_item3 = InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 10_000, status: 1) # packaged
    @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 30_400, status: 1) # packaged
    @invoice_item5 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 216, status: 1) # packaged
    @invoice_item6 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 18_905, status: 1) # packaged
    @invoice_item7 = InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 750, status: 1) # packaged
    @invoice_item8 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 55_286, status: 1) # packaged
    @invoice_item9 = InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 84_216, status: 1) # packaged

    @transaction1 = @invoice1.transactions.create!(credit_card_number: 4515551623735607, result: 0) # failed
    @transaction2 = @invoice2.transactions.create!(credit_card_number: 4515551623735607, result: 1) # success
    @transaction3 = @invoice3.transactions.create!(credit_card_number: 4173081602435789, result: 1) # success

    visit merchant_items_path(@merchant1)
  end

  it 'shows the top 5 most popular item names ranked by total revenue' do
    within "#top-5-items-by-total-revenue" do
      expect(page).to have_content('Top 5 Most Popular Items')
      expect(page).to have_content([@invoice_item9, @invoice_item8, @invoice_item4, @invoice_item6, @invoice_item3])
      expect(page).to_not have_content([@invoice_item5, @invoice_item7])
    end

Merchant - start here; Merchant.items only return the items related to a specific merchant

-id

Item
-id
-merchant_id

InvoiceItems
-item_id
-invoice_id
-(quantity x unit_price) as revenue

Invoices
-id

Transaction
-invoice_id
-result.where(result: 1)

revenue order: :desc
.limit(5)

    # As a merchant
    # When I visit my items index page
    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name

    # Only invoices with at least one successful transaction should count towards revenue
      # Transaction.where(result: 1)
      # join invoices and transactions table

    # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
  end

  it 'lists all of the items for a merchant' do
    expect(page).to have_content("#{@merchant1.name}'s Items")
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).to have_no_content(@merchant2.name)
    expect(page).to have_no_content(@item4.name)
    expect(page).to have_no_content(@item5.name)
  end

  it 'has a button next to each enabled item name to disable that item' do
    within "#item-#{@item1.id}" do
      expect(@item1.enabled).to eq(true)
      expect(page).to have_no_button('Enable')
      expect(page).to have_button('Disable')

      click_on 'Disable'

      expect(current_path).to eq(merchant_items_path(@merchant1))
      expect(@item1.reload.enabled).to eq(false)
      expect(page).to have_button('Enable')
      expect(page).to have_no_button('Disable')
    end

    expect(page).to have_content("#{@item1.name}'s information was successfully updated!")

    within "#item-#{@item2.id}" do
      expect(page).to have_no_button('Enable')
      expect(page).to have_button('Disable')
    end

    within "#item-#{@item3.id}" do
      expect(page).to have_button('Enable')
      expect(page).to have_no_button('Disable')
    end
  end

  it 'has a button next to each disabled item name to enable that item' do
    visit merchant_items_path(@merchant2)

    within "#item-#{@item4.id}" do
      expect(@item4.enabled).to eq(true)
      expect(page).to have_no_button('Enable')
      expect(page).to have_button('Disable')
    end

    within "#item-#{@item5.id}" do
      expect(page).to have_button('Enable')
      expect(page).to have_no_button('Disable')

      click_on 'Enable'

      expect(current_path).to eq(merchant_items_path(@merchant2))
      expect(@item5.reload.enabled).to eq(true)
      expect(page).to have_no_button('Enable')
      expect(page).to have_button('Disable')
    end

    expect(page).to have_content("#{@item5.name}'s information was successfully updated!")
  end

  it 'has two sections: one for enabled items and one for disabled items' do
    within '#all-enabled' do
      expect(page).to have_content('Enabled Items')
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_no_content(@item3.name)
    end

    within '#all-disabled' do
      expect(page).to have_content('Disabled Items')
      expect(page).to have_no_content(@item1.name)
      expect(page).to have_no_content(@item2.name)
      expect(page).to have_content(@item3.name)
    end
  end
end
