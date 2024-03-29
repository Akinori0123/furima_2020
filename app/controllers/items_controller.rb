class ItemsController < ApplicationController
  before_action :select_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_to_show, only: [:edit, :update, :destroy]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      return redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    return redirect_to root_path if @item.order != nil
  end

  def update
    if @item.update(item_params)
      return redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    if @item.destroy
      return redirect_to root_path
    else
      render 'show'
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :sales_status_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price,
      images: [] #これは指摘しなくてOKです！
    ).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end

  def redirect_to_show
    return redirect_to root_path if current_user.id != @item.user.id || @item.order != nil
  end
end
