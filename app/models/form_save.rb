class FormSave
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_id

  # orders_table
    # user, itemは外部キー
  # purchaser_table
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}[-][0-9]{4}\z/ } # 7桁の数字と4文字目にハイフン
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A[0-9]{,11}\z/ }  # ゼロ落ち対策でカラムはstring型。数字だけを指定するバリデーションが必須。
    # buildingは必須ではない
    # orderは外部キー 
  end

  def save
    # ユーザーの情報を保存し、「user」という変数に入れている
    order = Order.create(user_id: current_user.id, item_id: @item.id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, order_id: order.id)
  end
end