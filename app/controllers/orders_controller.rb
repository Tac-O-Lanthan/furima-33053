class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  before_action :access_normalization

  def index
    # params[:id] はエラー。ordersコントローラーに処理が渡ったので、pathから渡されるのは「item_id」
    @form_save = FormSave.new
  end

  def create
    @form_save = FormSave.new(form_save_params)
    if @form_save.valid?
      pay_item
      @form_save.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def form_save_params
    params.require(:form_save).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
    # params[:item_id]は「items_path」でparamsに渡されてきたid＝ordersコントローラーでの「item_id」キーを取得している
  end

  def pay_item
    Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: form_save_params[:token],
      currency: 'jpy'
    )
  end

  def access_normalization
    # 「売却済み商品への全てのユーザーの購入に関するアクセスをトップページに送る」処理と、
    # 「出品者が自身の出品する商品を購入するためのアクセスをトップページに送る」処理
    redirect_to root_path if @item.order || current_user == @item.user
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
