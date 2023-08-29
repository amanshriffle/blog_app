class ApplicationController < ActionController::API
  before_action :authenticate_request
  around_action :check_profile
  rescue_from CanCan::AccessDenied, with: :handle_access_denied

  include JsonWebToken
  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers["Authorization"]
    if header
      header = header.split(" ").last
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: "Authorization failed, please use valid JWT." }, status: :unauthorized
    end
  end

  def check_profile
    profile = current_user.profile

    if profile.first_name.nil? || profile.last_name.nil? || profile.date_of_birth.nil?
      render json: { error: "Please update your profile details first." }, status: :forbidden
    else
      yield
    end
  end

  def handle_access_denied
    render json: { error: "User is not authorized to perform this action" }, status: :unauthorized
  end
end
