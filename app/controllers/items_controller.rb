class ItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:merchant_id])
      @merchant = Merchant.find(params[:merchant_id])
    else
      flash[:alert] = ["Merchant #{params[:merchant_id]} Does Not Exist! Please choose a merchant =< #{Merchant.count}", "alert-danger"]
      redirect_to request.env["HTTP_REFERER"]
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    if item.save
      if item_params['enabled'] != nil
        redirect_to merchant_items_path
      else
        flash[:notice] = ["#{item.name}'s information was successfully updated!", "alert-success"]
        redirect_to merchant_item_path
      end
    else
      flash[:alert] = ["#{item.name}'s information was not successfully updated.", "alert-danger"]
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    Item.create(item_params)
    redirect_to merchant_items_path
  end

  private

  def item_params
    params.require(:item)
          .permit(:name, :description, :unit_price, :enabled, :merchant_id)
  end
end
