require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address, user_id: @user.id, item_id: @item.id)
    sleep(1)
  end

  describe '購入情報の保存' do
    context '購入情報が保存できる場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_shipping_address).to be_valid
      end
      it '建物名がなくても購入情報が保存できること' do
        @purchase_record_shipping_address.building_name = nil
        expect(@purchase_record_shipping_address).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_record_shipping_address.post_code = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が半角ハイフンを含む形でなければ保存できないこと' do
        @purchase_record_shipping_address.post_code = '1234567'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Post code is invalid')
      end

      it '都道府県が空だと保存できないこと' do
        @purchase_record_shipping_address.prefectures_id = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefectures can't be blank")
      end

      it '市区町村が空だと保存できないこと' do
        @purchase_record_shipping_address.municipalities = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '通り名が空だと保存できないこと' do
        @purchase_record_shipping_address.street_address = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @purchase_record_shipping_address.telephone_number = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @purchase_record_shipping_address.telephone_number = '090111111'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end

      it '電話番号が12桁以上では購入できない' do
        @purchase_record_shipping_address.telephone_number = '090111111111'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end

      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @purchase_record_shipping_address.telephone_number = '0901234abc'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end

      it 'トークンが空だと保存できないこと' do
        @purchase_record_shipping_address.token = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていなければ購入できない' do
        @purchase_record_shipping_address.user_id = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ購入できない' do
        @purchase_record_shipping_address.item_id = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
