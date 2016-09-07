class Api::V1::Customers::MerchantsController < Api::V1::BaseController
  def show
    customer = Customer.find(params[:id])

    respond_with customer.favorite_merchant
  end
end
