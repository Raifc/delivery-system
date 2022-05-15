class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
    @companies = Company.all
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: 'Vehicle successfully created'
    else
      flash.now[:notice] = 'Vehicle not created'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to vehicle_path(vehicle.id), notice: 'Vehicle successfully updated'
    else
      flash.now[:notice] = 'Vehicle not updated'
      render 'edit'
    end
  end

  def destroy
    @vehicle.destroy
    redirect_to root_path, notice: 'Vehicle successfully deleted'
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:license_plate, :brand, :model, :year, :load_capacity, :company_id)
  end

end
