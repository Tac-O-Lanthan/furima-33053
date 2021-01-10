# README

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               | <!-- 6文字以上半角英数字>
| last_name          | string  | null: false               | <!-- 全角かなカナ漢字>
| first_name         | string  | null: false               | <!-- 全角かなカナ漢字>
| last_name_kana     | string  | null: false               | <!-- 全角カナ>
| first_name_kana    | string  | null: false               | <!-- 全角カナ>
| birth_date         | date    | null: false               | 

### Association

- has_many :items
- has_many :buyers

## items テーブル

| Column                   | Type       | Options           |
| ------------------------ | ---------- | ----------------- |
| name                     | string     | null: false       | <!-- 40文字以内 >
| info                     | text       | null: false       | <!-- 1,000文字以内>
| category_id              | integer    | null: false       | <!-- active_hashのため.*_id, integer>
| sales_status_id          | integer    | null: false       |
| shipping_fee_status_id   | integer    | null: false       |
| prefecture_id            | integer    | null: false       |
| scheduled_delivery_id    | integer    | null: false       |
| price                    | integer    | null: false       | <!-- 値が300以上かつ9,999,999以下>
| user                     | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :buyer

## buyers テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :order

## orders テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| postal_code    | string     | null: false       | <!-- 4文字目にハイフンが必要>
| prefecture_id  | integer    | null: false       |
| city           | string     | null: false       |
| addresses      | string     | null: false       |
| building       | string     |                   |
| phone_number   | string     | null: false       | <!-- 半角英数字9文字以上>
| buyer          | references | foreign_key: true |

### Association

- has_one :buyer