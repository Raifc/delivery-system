class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[edit update]
  before_action :authenticate_admin!, only: [:new]

  def index
    @company = Company.find(params[:company_id])
    @service_orders = @company.service_orders.all
  end

  def new
    @company = Company.find(params[:company_id])
    @products = Product.all
    @service_order = @company.service_orders.new
  end

  def create
    @company = Company.find(params[:company_id])
    service_order_parameters = service_order_params
    origin_address_parameters = service_order_params.fetch(:origin_address)
    destination_address_parameters = service_order_params.fetch(:destination_address)

    @service_order = ServiceOrder.new(service_order_parameters)
    @origin_address = Address.create!(origin_address_parameters)
    @destination_address = Address.create!(destination_address_parameters)
    @service_order.origin_address_id = @origin_address.id
    @service_order.destination_address_id = @destination_address.id
    @service_order.company = @company

    if @service_order.save
      redirect_to company_service_orders_path(@service_order.company_id), notice: 'Service Order successfully created'
    else
      flash.now[:notice] = 'Service Order not created'
      render 'new'
    end

  end

  def show
    @service_order = ServiceOrder.find(params[:id])
    @origin_address = Address.find_by(id: @service_order.origin_address_id)
    @destination_address = Address.find_by(id: @service_order.destination_address_id)
    @vehicle = Vehicle.find_by(id: @service_order.vehicle_id)
  end

  def edit
    @company = Company.find(params[:company_id])
    @vehicles = @company.vehicles.all
  end

  def search
    @code = params[:query]
    @service_order = ServiceOrder.find_by(code: @code)
    @origin_address = Address.find_by(id: @service_order.origin_address_id)
    @destination_address = Address.find_by(id: @service_order.destination_address_id)
  end

  def update
    if @service_order.update(service_order_params)
      redirect_to company_service_orders_path(@service_order.company_id), notice: 'Service Order Sucessfully Updated'
    else
      flash.now[:notice] = 'Service Order not updated'
      @products = Product.all
      @company = Company.find(params[:company_id])
      @vehicles = @company.vehicles.all
      render 'edit'
    end
  end

=begin
  def service_order_review
    @company = Company.find(params[:company_id])
    @service_order = @company.service_orders.find(params[:service_order_id])
    @vehicles = @company.vehicles.all
    @service_order.vehicle_id = params[:vehicle_id]
    @service_order.status = params[:status]
    @service_order.save
  end
=end

  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def service_order_params
    params.require(:service_order).permit(:company_id, :code, :status, :product_id, :vehicle_id,
                                          origin_address: [:id, :full_address, :city, :state, :addressable_type],
                                          destination_address: [:id, :full_address, :city, :state, :addressable_type])
  end

end
