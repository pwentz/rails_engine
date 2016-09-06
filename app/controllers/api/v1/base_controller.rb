class Api::V1::BaseController < ApplicationController
  include RandomSelectorService

  respond_to :json
end
