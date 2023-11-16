require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      # ニックネームに関するテスト
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      # メールアドレスに関するテスト
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性でないと登録できない' do
        FactoryBot.create(:user, email: @user.email)
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@が含まれていないと登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      # パスワードに関するテスト
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字以上でないと登録できない' do
        @user.password = '1a2b'
        @user.password_confirmation = '1a2b'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英数字混合でないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end
      it 'パスワードとパスワード（確認）が一致しないと登録できない' do
        @user.password = '1a2b3c'
        @user.password_confirmation = '3c2b1a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      # お名前（全角）に関するテスト
      it '名字が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名字が全角でないと登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
      end
      it '名前が全角でないと登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
      end

      # お名前カナ（全角）に関するテスト
      it '名字カナが空だと登録できない' do
        @user.last_name_furigana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name furigana can't be blank")
      end
      it '名前カナが空だと登録できない' do
        @user.first_name_furigana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name furigana can't be blank")
      end
      it '名字カナが全角カタカナでないと登録できない' do
        @user.last_name_furigana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name furigana is invalid. Input full-width katakana characters')
      end
      it '名前カナが全角カタカナでないと登録できない' do
        @user.first_name_furigana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name furigana is invalid. Input full-width katakana characters')
      end

      # 生年月日に関するテスト
      it '生年月日が空だと登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
