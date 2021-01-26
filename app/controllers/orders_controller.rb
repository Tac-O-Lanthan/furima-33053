class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    # params[:id]はitemsテーブルの:idを参照する形。ordersコントローラーでは、ordersテーブルの:item_idを参照する形にする必要がある。
    @form_save = FormSave.new
  end

  def create
    @form_save = FormSave.new(form_save_params)
    if @form_save.valid?
      @form_save.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def form_save_params
    params.require(:form_save).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_id)
  end
end
