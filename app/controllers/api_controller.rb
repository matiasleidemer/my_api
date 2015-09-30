class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :set_default_response_format
  before_action :authenticate

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message, status: :unauthorized
  end

  def current_user
    @current_user ||= authenticate
  end
  helper_method :current_user

  private

  def authenticate
    authenticate_with_http_basic { |e, p| User.authenticate(e, p) } ||
      request_http_basic_authentication
  end

  def set_default_response_format
    request.format = :json
  end
end
