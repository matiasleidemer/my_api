class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  acts_as_token_authentication_handler_for User, fallback: :none

  load_and_authorize_resource

  before_action :set_default_response_format

  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message, status: :unauthorized
  end

  private

  def set_default_response_format
    request.format = :json
  end
end
