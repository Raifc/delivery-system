class RouteUpdatesController < ApplicationController
  before_action :set_route_update, only: [:show]
  before_action :authenticate_user!

  def index
    @company = Company.find(params[:company_id])
    @service_order = ServiceOrder.find(params[:service_order_id])
    @route_updates = @service_order.route_updates.all
  end

  def new
    @company = Company.find(params[:company_id])
    @service_order = ServiceOrder.find(params[:service_order_id])
    @route_update = @service_order.route_updates.new
  end

  def create
    @service_order = ServiceOrder.find(params[:service_order_id])
    @route_update = RouteUpdate.new(route_update_params)
    @route_update.service_order = @service_order

    if @route_update.save
      redirect_to company_service_order_route_updates_path, notice: 'Atualização de rota criada com sucesso!'
    else
      flash.now[:notice] = 'Falha ao criar atualização de rota'
      render 'new'
    end
  end

  def show; end

  private

  def set_route_update
    @route_update = RouteUpdate.find(params[:id])
  end

  def route_update_params
    params.require(:route_update).permit(:service_order_id, :company_id, :city, :date, :time)
  end

end
