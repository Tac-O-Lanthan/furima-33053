class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :access_normalization, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def access_normalization
    # 「売却済み商品の編集ページへのアクセスをトップページに送る」処理は「購入履歴モデル」実装のあとに追って実装

    # 「非ログインユーザーのアクセスをログインページに送る」処理と「出品者以外のユーザーのアクセスをトップページに送る」処理
    redirect_to user_session_path unless current_user == @item.user
  end
end
