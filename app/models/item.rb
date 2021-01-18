class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :info
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :sales_status_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
    validates :price, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9_999_999
    }
  end

  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :salesstatus
  belongs_to :shippingfeestatus
  belongs_to :prefecture
  belongs_to :scheduleddelivery
end

# user_idのNOT FALSEはforeign_key :trueに含まれている
