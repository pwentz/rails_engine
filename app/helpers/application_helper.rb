module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def formatted_date
    params[:date].to_time.utc
  end

  def to_price(number)
    number_with_precision(
      number,
      precision: 2
    )
  end

  def formatted_cc_number(transaction)
    transaction.credit_card_number.to_s
  end

  def formatted_price(object)
    (object.unit_price / 100.0).to_s
  end
end
