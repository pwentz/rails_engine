module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def to_price(raw_number)
    number = raw_number / 100.0
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
