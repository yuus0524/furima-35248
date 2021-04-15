require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    before do
      @product = FactoryBot.build(:product)
    end

    context '商品が出品できるとき' do
      it 'image,product_name,description,category_id,condition_id,delivery_burden_id,prefecture_id,days_to_ship_id,priceが存在していれば保存できること' do
        expect(@product).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it 'imageか空では保存できないこと' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it 'product_nameが空では保存できないこと' do
        @product.product_name = ""
        @product.valid?
        expect(@product.errors.full_messages).to include("Product name can't be blank")
      end

      it 'descriptionが空では保存できないこと' do
        @product.description = ""
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが選択されていない(idが1)と保存できないこと' do
        @product.category_id = "1"
        @product.valid?
        expect(@product.errors.full_messages).to include("Category Select")
      end

      it 'condition_idが選択されていない(id:1)と保存できないこと' do
        @product.condition_id = "1"
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition Select")
      end

      it 'delivery_burden_idが選択されていない(id:1)と保存できないこと' do
        @product.delivery_burden_id = "1"
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery burden Select")
      end

      it 'prefecture_idが選択されていない(id:1)と保存できないこと' do
        @product.prefecture_id = "1"
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture Select")
      end

      it 'days_to_ship_idが選択されていない(id:1)と保存できないこと' do
        @product.days_to_ship_id = "1"
        @product.valid?
        expect(@product.errors.full_messages).to include("Days to ship Select")
      end

      it 'priceが空だと保存できないこと' do
        @product.price = ""
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角の場合保存できないこと' do
        @product.price = "あああああ"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Half-width number")
      end

      it 'priceが半角英字の場合保存できないこと' do
        @product.price = "aaaaa"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Half-width number")
      end

      it 'priceが300より小さい数字の場合保存できないこと' do
        @product.price = "299"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end

      it 'priceが9,999,999より大きい数字の場合保存できないこと' do
        @product.price = "10,000,000"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price Out of setting range")
      end

      it 'userが紐付いていないと保存できないこと' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("User must exist")
      end
    end
  end
end
