class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: %i[edit update]
  before_action :set_company, only: %i[index new create show edit]
  before_action :authenticate_admin!, only: [:new]
  before_action :authenticate_user_or_admin, only: %i[show edit update index]

  def index
    @service_orders = @company.service_orders.all
    check_user if user_signed_in?
  end

  def new
    @products = Product.all
    @service_order = @company.service_orders.new
    @origin_address = Address.new
    @destination_address = Address.new
  end

  def create
    service_order_parameters = service_order_params
    origin_address_parameters = service_order_params.fetch(:origin_address)
    destination_address_parameters = service_order_params.fetch(:destination_address)

    @service_order = ServiceOrder.new(service_order_parameters)
    @origin_address = Address.new(origin_address_parameters)
    @destination_address = Address.new(destination_address_parameters)
    @service_order.company = @company

    @origin_address.save!
    @destination_address.save!
    @service_order.origin_address_id = @origin_address.id
    @service_order.destination_address_id = @destination_address.id

    if @service_order.save!
      redirect_to company_service_orders_path(@service_order.company_id), notice: 'Ordem de serviço criada com sucesso!'
    end

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:notice] = 'Falha ao criar ordem de serviço'
    @products = Product.all
    render 'new'

  end

  def show
    @service_order = ServiceOrder.find(params[:id])
    @origin_address = Address.find_by(id: @service_order.origin_address_id)
    @destination_address = Address.find_by(id: @service_order.destination_address_id)
    @vehicle = Vehicle.find_by(id: @service_order.vehicle_id)
    check_user if user_signed_in?
  end

  def edit
    @vehicles = @company.vehicles.all
    check_user if user_signed_in?
  end

  def search
    @code = params[:query]
    @service_order = ServiceOrder.find_by(code: @code)
    if @service_order.present?
      @origin_address = Address.find_by(id: @service_order.origin_address_id)
      @destination_address = Address.find_by(id: @service_order.destination_address_id)
    else
      redirect_to root_path, notice: 'Não encontrado'
    end
  end

  def update
    if @service_order.update(service_order_params)
      redirect_to company_service_orders_path(@service_order.company_id), notice: 'Ordem de serviço atualizada com sucesso!'
    else
      flash.now[:notice] = 'Falha ao atualizar ordem de serviço'
      @products = Product.all
      @company = Company.find(params[:company_id])
      @vehicles = @company.vehicles.all
      render 'edit'
    end
  end

  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def service_order_params
    params.require(:service_order).permit(:company_id, :code, :status, :product_id, :vehicle_id,
                                          origin_address: %i[id full_address city state addressable_type],
                                          destination_address: %i[id full_address city state addressable_type])
  end

  def check_user
    redirect_to root_path, notice:'Acesso não permitido' if current_user.company_id != @company.id
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

end
