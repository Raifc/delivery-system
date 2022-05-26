class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    admin_signed_in? ? companies_path : company_path(current_user.company)
  end

  def authenticate_user_or_admin
    authenticate_user! unless admin_signed_in?
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
