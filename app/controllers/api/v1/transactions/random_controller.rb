class Api::V1::Transactions::RandomController < Api::V1::BaseController
  def show
    transaction = random(Transaction)

    respond_with transaction
  end
end
