class PricesController < ApplicationController
  before_action :set_price, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @company = Company.find(params[:company_id])
    @prices = @company.prices.all

    @prices.each do |price|
      price.km_value = price.km_value / 100
    end

    redirect_to root_path if current_user.company_id != @company.id
  end

  def new
    @company = Company.find(params[:company_id])
    @price = Price.new
    check_user
  end

  def create
    @company = Company.find(params[:company_id])
    @price = Price.new(price_params)
    @price.company = @company

    if @price.save
      redirect_to company_prices_path(@price.company_id), notice: 'Preço criado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao criar preço'
      render 'new'
    end
  end

  def update
    if @price.update(price_params)
      redirect_to company_prices_path(@price.company_id), notice: 'Preço atualizado com sucesso'
    else
      flash.now[:notice] = 'Falha ao atualizar preço'
      render 'edit'
    end
  end

  def show
    @company = Company.find(params[:company_id])
    check_user
  end

  def edit
    @company = Company.find(params[:company_id])
    check_user
  end

  private

  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
    params.require(:price).permit(:min_volume, :max_volume, :min_weight, :max_weight, :km_value, :company_id)
  end

  def check_user
    redirect_to root_path if current_user.company_id != @company.id
  end

end
