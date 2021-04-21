class PurchaseRecordsController < ApplicationController

  def index
    @purchase_address = PurchaseAddress.new
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    @purchase_address = PurchaseAddress.new(purchase_record_params)
    if @purchase_address.valid?
      @purchase_address.save
    else
      render :index
    end
  end

  private
  def purchase_record_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :block, 
                                             :building, :phone_number).merge(user_id: current_user.id, product_id: @product.id)
  end

end
