# README

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false, unique: true |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               | <!-- 6文字以上半角英数字>
| last-name          | string  | null: false               | <!-- 全角かなカナ漢字>
| first-name         | string  | null: false               | <!-- 全角かなカナ漢字>
| last-name-kana     | string  | null: false               | <!-- 全角カナ>
| first-name-kana    | string  | null: false               | <!-- 全角カナ>
| birth-date         | date    | null: false               | 

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                   | Type       | Options           |
| ------------------------ | ---------- | ----------------- |
| item-image               |            |                   | <!-- 別途実装>
| name                     | string     | null: false       | <!-- 40文字以内 >
| info                     | text       | null: false       | <!-- 1,000文字以内>
| category                 | string     | null: false       |
| sales-status             | string     | null: false       |
| shipping-fee-status      | string     | null: false       |
| prefecture               | string     | null: false       |
| scheduled-delivery       | string     | null: false       |
| price                    | integer    | null: false       | <!-- 値が300以上かつ9,999,999以下>
| user                     | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| postal-code    | string     | null: false       | <!-- 4文字目にハイフンが必要>
| prefecture     | string     | null: false       |
| city           | string     | null: false       |
| addresses      | string     | null: false       |
| building       | string     |                   |
| phone-number   | string     | null: false       | <!-- 半角英数字9文字以上>
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :item
