class Api::V1::Transactions::InvoiceController < Api::V1::BaseController
  def show
    @invoice = Transaction.find(params[:id]).invoice
    render 'api/v1/invoices/show'
  end
end
