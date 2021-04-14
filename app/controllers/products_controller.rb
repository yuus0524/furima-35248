class ProductsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def new
  end

  private

  def product_params
    params.require(:product).permit(:image).merge(user_id: current_user.id)
  end
end
