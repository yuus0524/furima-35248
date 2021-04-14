require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'last_nameが空では登録できないこと' do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空では登録できないこと' do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_name_kanaが空では登録できないこと' do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが空では登録できないこと' do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'birthdayが空だと登録できないこと' do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが5文字以下だと半角英数混合でも登録できないこと' do
      @user.password = "aaa11"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordが6文字以上でも半角英数字混合でない場合登録できないこと' do
      @user.password = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end

    it 'passwordが全角だと登録できないこと' do
      @user.password = "ああああああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください"])
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = "aaa111"
      @user.password_confirmation = "bbb222"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'last_nameは全角(漢字、ひらがな、カタカナ)でなければ登録できないこと' do
      @user.last_name = "kana"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
    end

    it 'first_nameは全角(漢字、ひらがな、カタカナ)でなければ登録できないこと' do
      @user.first_name = "kana"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
    end

    it 'last_name_kanaは全角(カタカナ)でなければ登録できないこと' do
      @user.last_name_kana = "かな"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
    end

    it 'first_name_kanaは全角(カタカナ)でなければ登録できないこと' do
      @user.first_name_kana = "かな"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
    end
  end
end
