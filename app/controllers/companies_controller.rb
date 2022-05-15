class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @email_domains = EmailDomain.all
  end

  def create
    @company = Company.new(company_params)
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
    params.require(:company).permit(:corporate_name, :registration_number, :trading_name, :email_domain_id, :address_id)
  end

end
