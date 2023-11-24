class PurchaseRecordsController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :redirect_user, only: [:index]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_shipping_address_params)

    if @purchase_record_shipping_address.valid?
      pay_item
      @purchase_record_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_shipping_address_params
    params.require(:purchase_record_shipping_address)
          .permit(:user_id, :item_id, :post_code, :prefectures_id, :municipalities, :street_address, :building_name,
                  :telephone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_shipping_address_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_user
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end
  
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase_record.present?
  end
end
