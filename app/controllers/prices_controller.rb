class PricesController < ApplicationController
  before_action :set_price, only: %i[show edit update destroy]

  def index
    @company = Company.find(params[:company_id])
    @prices = Price.all
  end

  def new
    @company = Company.find(params[:company_id])
    @price = Price.new
  end

  def create
    @company = Company.find(params[:company_id])
    @price = Price.new(price_params)
    @price.company = @company

    if @price.save
      redirect_to company_prices_path, notice: 'Price successfully created'
    else
      flash.now[:notice] = 'Price not created'
      render 'new'
    end
  end

  def update
    if @price.update(price_params)
      redirect_to company_prices_path, notice: 'Price successfully updated'
    else
      flash.now[:notice] = 'Price not updated'
      render 'edit'
    end
  end

  def show; end

  def edit; end

  private

  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
    params.require(:price).permit(:min_volume, :max_volume, :min_weight, :max_weight, :km_value, :company_id)
  end

end
