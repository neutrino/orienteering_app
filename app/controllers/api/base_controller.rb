class Api::BaseController < ApplicationController
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: "Not Found"}, status: 404
  end
end