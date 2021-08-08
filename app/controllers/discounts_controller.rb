class DiscountsController < ApplicationController
  def index
    @discounts = Merchant.find(params['merchant_id']).discounts
  end

  private

  def discount_params
    params.permit(:merchant_id)
  end
end