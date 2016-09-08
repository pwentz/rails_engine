class Api::V1::Merchants::SearchController < Api::V1::BaseController
  def index
    @merchants = Merchant.where(merchant_params)
    render 'api/v1/merchants/index'
  end

  def show
    @merchant = Merchant.find_by(merchant_params)
    render 'api/v1/merchants/show'
  end

  private

  def merchant_params
    params.permit(
      :id,
      :name,
      :created_at,
      :updated_at
    )
  end
end
