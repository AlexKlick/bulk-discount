class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params['merchant_id'])
  end

  def show
    @discount = Discount.find(discount_params[:id])
  end

  def new
    @merchant = Merchant.find(params['merchant_id'])
    @discount = Discount.new
  end

  def create
    Discount.create(discount_params)
    redirect_to "/merchants/#{discount_params[:merchant_id]}/discounts"
  end
  private

  def discount_params
    params.permit(:merchant_id, :id, :percent_off, :quantity)
  end
end