class PricesController < ApplicationController
  before_action :set_price, only: %i[show edit update]
  before_action :set_company, only: %i[index new show edit create]
  before_action :authenticate_user!
  before_action :check_user, only: %i[index new show edit create]

  def index
    @prices = @company.prices.all

    @prices.each do |price|
      price.km_value = price.km_value / 100
    end

    redirect_to root_path if current_user.company_id != @company.id
  end

  def new
    @price = Price.new
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

  def show; end

  def edit; end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
    params.require(:price).permit(:min_volume, :max_volume, :min_weight, :max_weight, :km_value, :company_id)
  end

  def check_user
    redirect_to root_path, notice: 'Acesso não permitido' if current_user.company_id != @company.id
  end

end
