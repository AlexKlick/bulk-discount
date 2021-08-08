class DiscountsController < ApplicationController
  def index
    @discounts = Merchant.find(params['merchant_id']).discounts
  end
  def show
    @discount = Discount.find(discount_params[:id])
  end
  private

  def discount_params
    params.permit(:merchant_id, :id)
  end
end