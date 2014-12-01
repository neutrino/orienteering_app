class Api::BaseController < ApplicationController

  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found
    render json: { error: "Not Found"}, status: 404
  end

  def json_request?
    request.format.json?
  end

end