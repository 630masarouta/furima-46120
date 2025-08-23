class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました。'
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_if_not_owner
    redirect_to root_path unless current_user == @item.user
  end

  def redirect_if_sold_out
    redirect_to root_path unless @item.order.nil?
  end
end
