class Api::V1::BaseController < ApplicationController
  include RandomSelectorService

  helper_method :format_unit_price_param

  def format_unit_price_param
    if params[:unit_price] && params[:unit_price].include?('.')
      params[:unit_price] = (params[:unit_price].to_f * 100).round(0)
    end
  end
end
