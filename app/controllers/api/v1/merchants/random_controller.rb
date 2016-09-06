class Api::V1::Merchants::RandomController < Api::V1::BaseController
  def show
    merchant = Merchant.random

    respond_with merchant
  end
end
