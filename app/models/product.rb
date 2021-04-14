class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_burden
  belongs_to :prefecture
  belongs_to :days_to_ship
  belongs_to :user
  has_one_attached :image
end
