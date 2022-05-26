class CompaniesController < ApplicationController

  before_action :authenticate_user_or_admin, only: [:show]
  before_action :authenticate_admin!, only: %i[index new edit update]
  before_action :set_company, only: %i[show edit update]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    @company.build_address
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
      redirect_to company_path(@company.id), notice: 'Company successfully updated'
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
    params.require(:company).permit(:corporate_name, :registration_number, :trading_name, :status, :email_domain,
                                    address_attributes: %i[id full_address city state])
  end

end
