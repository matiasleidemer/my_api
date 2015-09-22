class ApiController < ApplicationController
  before_action :set_default_response_format

  load_and_authorize_resource

  private

  def set_default_response_format
    request.format = :json
  end
end
