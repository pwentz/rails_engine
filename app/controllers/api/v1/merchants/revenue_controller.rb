class Api::V1::Merchants::RevenueController < Api::V1::BaseController
  def index
    merchants = Merchant.most_revenue(params[:quantity])

    respond_with merchants
  end

  def show
    merchant = Merchant.find(params[:id])

    respond_with merchant.revenue(params[:date])
  end
end
