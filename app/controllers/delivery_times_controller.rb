class DeliveryTimesController < ApplicationController
  before_action :set_delivery_time, only: %i[show edit update]
  before_action :set_company, only: %i[index new create edit show]
  before_action :authenticate_user!
  before_action :check_user, only: %i[index new create edit show]

  def index
    @delivery_times = @company.delivery_times.all
  end

  def new
    @delivery_time = @company.delivery_times.new
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)
    @delivery_time.company = @company

    if @delivery_time.save
      redirect_to company_delivery_times_path(@delivery_time.company_id), notice: 'Tempo de entrega criado!'
    else
      flash.now[:notice] = 'Falha ao criar novo tempo de entrega'
      render 'new'
    end
  end

  def update
    if @delivery_time.update(delivery_time_params)
      redirect_to company_delivery_times_path(@delivery_time.company_id), notice: 'Tempo de entrega atualizado!'
    else
      flash.now[:notice] = 'Falha ao atualizar tempo de entrega!'
      render 'edit'
    end
  end

  def show; end

  def edit; end

  private

  def set_delivery_time
    @delivery_time = DeliveryTime.find(params[:id])
  end

  def delivery_time_params
    params.require(:delivery_time).permit(:company_id, :min_distance, :max_distance, :business_days)
  end

  def check_user
    redirect_to root_path, notice: 'Acesso não permitido' if current_user.company_id != @company.id
  end

end
