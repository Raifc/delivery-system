class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user_or_admin

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Produto criado com sucesso'
    else
      flash.now[:notice] = 'Falha ao criar produto'
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id), notice: 'Produto atualizado com sucesso!'
    else
      flash.now[:notice] = 'Falha ao atualizar produto'
      render 'edit'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:code, :height, :width, :depth, :weight)
  end

end
