class Api::V1::Customers::MerchantsController < Api::V1::BaseController
  def show
    @merchant = Customer.find(params[:id]).favorite_merchant
    render 'api/v1/merchants/show'
  end
end
