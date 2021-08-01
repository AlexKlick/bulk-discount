require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, enabled: true, merchant: @merchant1)
    @item2 = create(:item, enabled: true, merchant: @merchant1)
    @item3 = create(:item, enabled: false, merchant: @merchant1)
    @item4 = create(:item, enabled: true, merchant: @merchant2)
    @item5 = create(:item, enabled: false, merchant: @merchant2)

    visit merchant_items_path(@merchant1)
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

  it 'shows the top 5 most popular item names ranked by total revenue' do
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name
#
# Notes on Revenue Calculation:
#
# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
  end
end
