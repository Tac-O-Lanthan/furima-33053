class FormSave
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_id, :number, :exp_month, :exp_year, :cvc, :token

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
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Purchaser.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end