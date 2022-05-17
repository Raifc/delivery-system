class PricesController < ApplicationController
  def index
    @prices = Price.all
  end

  def new
    @price = Price.new
    @companies = Company.all
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      redirect_to @price, notice: 'Price successfully created'
    else
      flash.now[:notice] = 'Price not created'
      render 'new'
    end
  end

  def show
    @price = Price.find(params[:id])
  end

  private

  def price_params
    params.require(:price).permit(:min_volume, :max_volume, :min_weight, :max_weight, :km_value, :company_id)
  end

end
