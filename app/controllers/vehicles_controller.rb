class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i[show edit update destroy]

  def index
    @company = Company.find(params[:company_id])
    @vehicles = @company.vehicles.all
    check_user
  end

  def new
    @company = Company.find(params[:company_id])
    @vehicle = @company.vehicles.new #@vehicle = Vehicle.new
    check_user
  end

  def create
    @company = Company.find(params[:company_id])
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.company = @company

    if @vehicle.save
      redirect_to company_vehicles_path(@vehicle.company_id), notice: 'Veículo criado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao criar veículo!'
      render 'new'
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

  def update
    if @vehicle.update(vehicle_params)
      redirect_to company_vehicles_path(@vehicle.company_id), notice: 'Veículo atualizado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao atualizar veículo!'
      render 'edit'
    end
  end

  def destroy;  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
    #@company = Company.find(params[:company_id])
    #@vehicle = @company.vehicles.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:license_plate, :brand, :model, :year, :load_capacity, :company_id)
  end

  def check_user
    redirect_to root_path if current_user.company_id != @company.id
  end

end
