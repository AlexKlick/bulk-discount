class DashboardController < ApplicationController
  def index
    if Merchant.exists?(params[:merchant_id])
      @merchant = Merchant.find(params[:merchant_id])
    else
      flash[:alert] = ["Merchant #{params[:merchant_id]} Does Not Exist! Please choose a merchant =< #{Merchant.count}", "alert-danger"]
      redirect_to request.env["HTTP_REFERER"]
    end
  end
end
