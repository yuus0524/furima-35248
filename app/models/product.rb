class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_burden
  belongs_to :prefecture
  belongs_to :days_to_ship
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :price
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category_id
      validates :condition_id
      validates :delivery_burden_id
      validates :prefecture_id
      validates :days_to_ship_id
    end
  end

  validates :price,
              numericality: {
                with: /\A[0-9]+\z/,
                message: 'Half-width number'
            }
            
  validates :price,
              numericality: {
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9999999,
                message: 'Out of setting range'
            }
end
