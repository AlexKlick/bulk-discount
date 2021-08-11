require 'rails_helper'

RSpec.describe DiscountInventory do
  describe 'relationships' do
    it { should belong_to(:discount) }
    it { should belong_to(:invoice_item) }
  end

  describe 'class methods' do

  end
  describe 'instance methods' do

  end
end