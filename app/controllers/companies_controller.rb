class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @company.build_address
    @company.build_email_domain
  end

  def create

    @company = Company.new(company_params.fetch('company'))
    @address = Address.new(company_params.fetch('address'))
    @address.save
    @email_domain = EmailDomain.new(company_params.fetch('email_domain'))
    @email_domain.save
    @company.address = @address
    @company.email_domain = @email_domain


    if @company.save
      redirect_to @company, notice: 'Company successfully created'
    else
      flash.now[:notice] = 'Company not created'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to company_path(company.id), notice: 'Company successfully updated'
    else
      flash.now[:notice] = 'Company not updated'
      render 'edit'
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.permit(company: [:corporate_name, :registration_number, :trading_name], email_domain: [:domain], address: [:full_address, :city, :state])
  end

end
