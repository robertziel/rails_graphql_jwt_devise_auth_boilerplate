class ApplicationController < ActionController::API
  alias jwt_current_user current_user
  def current_user
    @current_user ||=
      jwt_current_user.nil? ? nil : User.find(jwt_current_user.id) # first is loaded by JWT
  end
end
