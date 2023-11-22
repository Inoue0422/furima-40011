require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address)
    sleep(1)
  end

  describe '購入情報の保存' do
    context '購入情報が保存できる場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_shipping_address).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_record_shipping_address.post_code = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code can't be blank")
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

      it 'トークンが空だと保存できないこと' do
        @purchase_record_shipping_address.token = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end