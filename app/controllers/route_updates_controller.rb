class RouteUpdatesController < ApplicationController
  before_action :set_route_update, only: [:show]
  before_action :set_company, only: %i[index show new create]
  before_action :set_service_order, only: %i[index show new create]
  before_action :authenticate_user!
  before_action :check_user, only: %i[index show new create]

  def index
    @route_updates = @service_order.route_updates.all
  end

  def new
    @route_update = @service_order.route_updates.new
  end

  def create
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

  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_route_update
    @route_update = RouteUpdate.find(params[:id])
  end

  def route_update_params
    params.require(:route_update).permit(:service_order_id, :company_id, :city, :date, :time)
  end

  def check_user
    redirect_to root_path, notice: 'Acesso não permitido' if current_user.company_id != @company.id
  end

end
