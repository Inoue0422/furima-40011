class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @item = Item.create(item_params)
  end

  Private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_charge_id, :region_id, :delivery_day_id, :price, :image).merge(uer_id: current_user.id)
  end
end
