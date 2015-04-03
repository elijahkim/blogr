class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    super || Guest.new
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t(
      "#{policy_name}.#{exception.query}",
      scope: "pundit",
      default: :default
    )
    redirect_to(request.referrer || root_path)
  end
end
