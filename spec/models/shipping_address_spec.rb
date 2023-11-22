require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  describe '配送先住所の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item, user: @user)
      @purchase_record = FactoryBot.create(:purchase_record, user: @user, item: @item)
      @shipping_address = FactoryBot.build(:shipping_address, purchase_record: @purchase_record)
      sleep(1)
    end

    context '配送先住所が保存できる場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@shipping_address).to be_valid
      end
    end

    context '配送先住所が保存できない場合' do
      it '郵便番号が空だと保存できないこと' do
        @shipping_address.post_code = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '都道府県が空だと保存できないこと' do
        @shipping_address.prefectures_id = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Prefectures can't be blank")
      end

      it '市区町村が空だと保存できないこと' do
        @shipping_address.municipalities = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '通り名が空だと保存できないこと' do
        @shipping_address.street_address = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @shipping_address.telephone_number = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
    end
  end
end
