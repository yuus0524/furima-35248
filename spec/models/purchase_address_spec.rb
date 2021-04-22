require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, product_id: product.id)
      sleep 0.1
    end

    context '商品が購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_address.building = ""
        @purchase_address.valid?
        expect(@purchase_address).to be_valid 
      end
    end

    context '商品が購入できないとき' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_address.post_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'prefecture_idがが選択されていない(id:1)と保存できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture Select")
      end

      it 'ciryが空だと保存できないこと' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'blockが空だと保存できないこと' do
        @purchase_address.block = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Block can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_address.phone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'post_codeは全角の場合保存できないこと' do
        @purchase_address.post_code = "あああああ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code Input correctly")
      end

      it 'post_codeは半角英字の場合保存できないこと' do
        @purchase_address.post_code = "aaaaa"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code Input correctly")
      end

      it 'post_codeは半角英数字混合の場合保存できないこと' do
        @purchase_address.post_code = "aa111"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code Input correctly")
      end

      it 'post_codeは-(ハイフン)を含んでいないと保存できないこと' do
        @purchase_address.post_code = "1234567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code Input correctly")
      end

      it 'post_codeは-(ハイフン)を数字3桁と数字4桁の間に含んでいないと保存できないこと' do
        @purchase_address.post_code = "12-34567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code Input correctly")
      end

      it 'phone_numberは全角の場合保存できないこと' do
        @purchase_address.phone_number = "あああああ"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
      end

      it 'phone_numberは半角英字の場合保存できないこと' do
        @purchase_address.phone_number = "aaaaa"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
      end

      it 'phone_numberは半角英数字混合の場合保存できないこと' do
        @purchase_address.phone_number = "aa111"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
      end

      it 'phone_numberは(ハイフン)を含んでいると保存できないこと' do
        @purchase_address.phone_number = "090-1234-5678"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number")
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'productが紐付いていないと保存できないこと' do
        @purchase_address.product_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Product can't be blank")
      end

      it 'tokenが空では保存できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
