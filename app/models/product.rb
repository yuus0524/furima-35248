class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_burden
  belongs_to :prefecture
  belongs_to :days_to_ship
  belongs_to :user
  has_one_attached :image

  validates :category_id, :condition_id, :days_to_ship_id, :delivery_burden_id, :prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :image, :product_name, :description, :price, presence: true
  validates :price, format: { with: /\A[0-9]+\z/, message: 'Price Half-width number' }
end
