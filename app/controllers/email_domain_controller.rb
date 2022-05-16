class EmailDomainController < ApplicationController
  before_action :set_email_domain, only: [:show, :edit, :update, :destroy]

  def index; end

  def new
    @email_domain = EmailDomain.new
  end

  def create
    @email_domain = EmailDomain.new(email_domain_params)
    @email_domain.save
  end

  def show; end

  def edit; end

  def update; end

  private

  def set_email_domain
    @email_domain = EmailDomain.find(params[:id])
  end

  def address_params
    params.require(:email_domain).permit(:domain)
  end

end
