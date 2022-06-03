class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show edit update destroy]
  before_action :set_company
  before_action :authenticate_user!
  before_action :check_user

  def index
    @vehicles = @company.vehicles.all
  end

  def new
    @vehicle = @company.vehicles.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.company = @company

    if @vehicle.save
      redirect_to company_vehicles_path(@vehicle.company_id), notice: 'Veículo criado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao criar veículo!'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to company_vehicles_path(@vehicle.company_id), notice: 'Veículo atualizado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao atualizar veículo!'
      render 'edit'
    end
  end

  def destroy; end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:license_plate, :brand, :model, :year, :load_capacity, :company_id)
  end

  def check_user
    redirect_to root_path if current_user.company_id != @company.id
  end

end
