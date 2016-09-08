class Api::V1::Merchants::DateRevenueController < Api::V1::BaseController
  def index
    @total_revenue = Merchant.revenue_on_date(params[:date])
  end
end
