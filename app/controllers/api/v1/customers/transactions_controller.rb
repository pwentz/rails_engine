class Api::V1::Customers::TransactionsController < Api::V1::BaseController
  def index
    @transactions = Customer.find(params[:id]).transactions
  end
end
