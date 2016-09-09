class Api::V1::Merchants::CustomersController < Api::V1::BaseController
  def index
    @customers =
      Merchant.find(params[:id]).customers_with_pending_invoices
    render 'api/v1/customers/index'
  end

  def show
    @customer = Merchant.find(params[:id]).favorite_customer
    render 'api/v1/customers/show'
  end
end
