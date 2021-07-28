require 'rails_helper'

RSpec.describe '/admin/merchants/merchant_id' do
  describe 'as an admin' do
    describe 'when I visit the admin merchants show page (/admin/merchants/merchant_id)' do
      let!(:merchant1) { create(:merchant) }
      let!(:merchant2) { create(:merchant) }
      let!(:merchant3) { create(:merchant) }
      let!(:merchants) { [merchant1, merchant2, merchant3] }

      before { visit "/admin/merchants/#{merchant1.id}" }

      specify { expect(current_path).to eq("/admin/merchants/#{merchant1.id}") }

      it 'displays the name of the merchant' do
        expect(page).to have_content(merchant1.name)
        expect(page).to have_no_content(merchant2.name)
        expect(page).to have_no_content(merchant3.name)
      end
    end
  end
end
