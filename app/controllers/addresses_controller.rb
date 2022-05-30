class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]
  #before_action :authenticate_user_or_admin

  def index; end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.save
  end

  def show; end

  def edit; end

  def update; end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:full_address, :city, :state)
  end

end
