class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :block, :building, :phone_number, :user_id, :product_id, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"}
    validates :prefecture_id, numericality: {other_than: 1, message: "Select"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A[0-9]{,11}+\z/, message: "Input only number"}
    validates :user_id
    validates :product_id
    validates :token
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, product_id: product_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, purchase_record_id: purchase_record.id)
  end
end