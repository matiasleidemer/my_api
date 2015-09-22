class ApiController < ApplicationController
  acts_as_token_authentication_handler_for User

  load_and_authorize_resource

  before_action :set_default_response_format

  private

  def set_default_response_format
    request.format = :json
  end
end
