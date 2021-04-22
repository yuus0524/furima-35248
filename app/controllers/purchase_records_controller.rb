class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :move_to_index

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_record_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
    else
      render :index
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :block,
                                             :building, :phone_number).merge(user_id: current_user.id, product_id: @product.id, token: params[:token])
  end

  def pay_item
    set_product
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id != @product.user_id && @product.purchase_record.blank?
  end
end
