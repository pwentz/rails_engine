class Api::V1::Merchants::RevenueController < Api::V1::BaseController
  def show
    merchant = Merchant.find(params[:id])

    respond_with merchant.revenue(params[:date])
  end
end
