class ApplicationController < ActionController::API
  alias jwt_current_user current_user
  def current_user
    @current_user ||= User.find_by(id: jwt_current_user.id) # first is loaded by JWT
  end
end
