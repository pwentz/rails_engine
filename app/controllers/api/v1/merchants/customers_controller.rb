class Api::V1::Merchants::CustomersController < Api::V1::BaseController
  def index
    merchant = Merchant.find(params[:id])

    respond_with merchant.customers_with_pending_invoices
  end

  def show
    merchant = Merchant.find(params[:id])

    respond_with merchant.favorite_customer
  end
end
