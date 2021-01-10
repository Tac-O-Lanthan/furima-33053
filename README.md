# README

## users テーブル

| Column          | Type    | Options                   |
| --------------- | ------- | ------------------------- |
| nickname        | string  | null: false, unique: true |
| email           | string  | null: false, unique: true |
| password        | string  | null: false               | <!-- 6文字以上半角英数字>
| last-name       | string  | null: false               | <!-- 全角かなカナ漢字>
| first-name      | string  | null: false               | <!-- 全角かなカナ漢字>
| last-name-kana  | string  | null: false               | <!-- 全角カナ>
| first-name-kana | string  | null: false               | <!-- 全角カナ>
| birth-date      | integer | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                   | Type       | Options           |
| ------------------------ | ---------- | ----------------- |
| item-image               |            |                   | <!-- 別途実装>
| item-name                | string     | null: false       | <!-- 40文字以内 >
| item-info                | text       | null: false       | <!-- 1,000文字以内>
| item-category            | string     | null: false       |
| item-sales-status        | string     | null: false       |
| item-shipping-fee-status | string     | null: false       |
| item-prefecture          | string     | null: false       |
| item-scheduled-delivery  | string     | null: false       |
| item-price               | integer    | null: false       | <!-- 値が300以上かつ9,999,999以下>
| user_id                  | references | foreign_key: true |

### Association

- belongs_to :user
- has_many :orders

## orders テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| card-number    | integer    | null: false       | <!-- 半角英数字>
| card-exp-month | integer    | null: false       | <!-- 半角英数字1~2文字>
| card-exp-year  | integer    | null: false       | <!-- 半角英数字1~2文字>
| card-cvc       | integer    | null: false       | <!-- 半角英数字3~4文字>
| postal-code    | string     | null: false       | <!-- 4文字目にハイフンが必要>
| prefecture     | string     | null: false       |
| city           | string     | null: false       |
| addresses      | string     | null: false       |
| building       | string     |                   |
| phone-number   | integer    | null: false       | <!-- 半角英数字9文字以上>
| user_id        | references | foreign_key: true |
| item_id        | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
