class Api::V1::Invoices::CustomersController < Api::V1::BaseController
  def show
    customer = Invoice.find(params[:id]).customer

    respond_with customer
  end
end
