class InvoicesController < ApplicationController
  before_action :get_merchant, only: [:index, :show]

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def get_merchant
    if Merchant.exists?(params[:merchant_id])
      @merchant = Merchant.find(params[:merchant_id])
    else
      flash[:alert] = ["Merchant #{params[:merchant_id]} Does Not Exist! Please choose a merchant =< #{Merchant.count}", "alert-danger"]
      redirect_to request.env["HTTP_REFERER"]
    end
  end
end
