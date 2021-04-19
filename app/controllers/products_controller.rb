class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, only: :edit

  def index
    @products = Product.includes(:user).order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    if current_user.id == @product.user_id
      @product.destroy
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :product_name, :description, :category_id, :condition_id, :delivery_burden_id,
                                    :prefecture_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_index
    product = Product.find(params[:id])
    unless current_user.id == product.user_id
      redirect_to action: :index
    end
  end
end
