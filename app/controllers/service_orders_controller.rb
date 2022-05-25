class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[edit update destroy]

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
      redirect_to company_service_orders_path, notice: 'Service Order successfully created'
    else
      flash.now[:notice] = 'Service Order not created'
      render 'new'
    end

  end

  def show
    @service_order = ServiceOrder.find(params[:id])
    @origin_address = Address.find_by(id: @service_order.origin_address_id)
    @destination_address = Address.find_by(id: @service_order.destination_address_id)
  end

  def edit; end

  def search
    @code = params[:query]
    @service_order = ServiceOrder.find_by(code: @code)
    @origin_address = Address.find_by(id: @service_order.origin_address_id)
    @destination_address = Address.find_by(id: @service_order.destination_address_id)
  end

  def update
    if @service_order.update(service_order_params)
      redirect_to service_order_path(@service_order.id), notice: 'service_order successfully updated'
    else
      flash.now[:notice] = 'service_order not updated'
      @products = Product.all
      render 'edit'
    end
  end

  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def service_order_params
    params.require(:service_order).permit(:company_id, :code, :status, :product_id,
                                          origin_address: [:id, :full_address, :city, :state, :addressable_type],
                                          destination_address: [:id, :full_address, :city, :state, :addressable_type])
  end

end
