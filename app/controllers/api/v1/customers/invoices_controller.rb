class Api::V1::Customers::InvoicesController < Api::V1::BaseController
  def index
    invoices = Customer.find(params[:id]).invoices

    respond_with invoices
  end
end
