class Api::V1::Merchants::ItemsAnalysisController < Api::V1::BaseController
  def index
    @merchants = Merchant.most_items_sold(params[:quantity])
    render 'api/v1/merchants/index'
  end
end
