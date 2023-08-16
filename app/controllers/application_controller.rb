class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = jwt_decode(header)

    @current_user = User.select(:id, :username, :first_name, :last_name, :blogs_count).find(decoded[:user_id])
  end
end
