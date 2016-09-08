class Api::V1::Merchants::RevenueController < Api::V1::BaseController
  before_action :set_merchant

  def show
    @merchant_data = set_data_by_params
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def set_data_by_params
    if params[:date]
      @merchant.revenue_on_date(params[:date])
    else
      @merchant.revenue
    end
  end
end
