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

  def edit
    @discount = Discount.find(discount_params[:id])
  end

  def update
    discount = Discount.find(discount_params[:id])
    discount.update(discount_params)
    redirect_to "/merchants/#{discount_params[:merchant_id]}/discounts/#{discount.id}"
  end

  def destroy
    Discount.destroy(discount_params[:id])
    redirect_to "/merchants/#{discount_params[:merchant_id]}/discounts"
  end
  private

  def discount_params
    if params[:discount]
      hash = {:merchant_id => params[:merchant_id], :id => params[:id]}
      params[:discount] = params[:discount].merge(hash)
      params.require(:discount).permit(:merchant_id, :id, :percent_off, :quantity)
    else
      params.permit(:merchant_id, :id, :percent_off, :quantity)
    end
  end
end