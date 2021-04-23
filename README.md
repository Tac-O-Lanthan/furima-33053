# フリマアプリ「FURIMA」
https://furima-33053on90.herokuapp.com/

![メインページ](https://user-images.githubusercontent.com/75772499/110417761-7094f180-80d9-11eb-88eb-8aa96ed3654b.png)
- 一部、未実装の機能もございます。

## 概要
- FURIMAはユーザー登録制のフリーマーケット・アプリケーションです。  
- このアプリは、技術的なスキルアップのためのアプリです。
- AWS上のバケットを削除したため、現在はHeroku上での画像アップロードができません。

## 機能
| 機能 | 概要 |
| :--- | :--- |
| ユーザー管理機能 | 本アプリにサインイン・ログイン・ログアウトできます |
| 商品出品機能 | ログインすると、売却したい商品を出品できます |
| 商品詳細表示機能 | 出品されている商品をクリックすると、詳細ページが表示されます |
| 商品管理機能 | 出品した商品の情報を編集したり、出品を取り下げたりできます |
| 商品購入機能 | ログインすると、出品されている商品を購入できます |
- 商品詳細の表示はログインしていないユーザーでもご利用いただけます。
- 商品の購入については、クレジットカードでの決済になります。

## 接続先情報
| ベーシック認証 |   |
| :--- | :--- |
| ID | on90 |
| Pass | on90 |

| テスト用アカウント（購入者）|   |
| :--- | :--- |
| メールアドレス | buyer@buyer |
| パスワード | buyer000 |

| テスト用アカウント（出品者）|   |
| :--- | :--- |
| メールアドレス | seller@seller |
| パスワード | seller000 |


| テスト用クレジットカード |   |
| :--- | :--- |
| 番号 | 4242424242424242 |
| 期限 | 3月 33年 |
| CVC | 123 |

## 開発環境
| ソフトウェア |
| :--- |
| VScode |
| Ruby 2.6.5p114 |
| Rubygems 3.0.3 |
| Rails 6.0.3.4 |
| mysql2 0.5.3 |
| HTML/CSS |
| JavaScript |
| heroku 7.49.1 |
| git 2.24.3 |

# データベース設計

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
- has_one :order

## orders テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :purchaser

## purchaser テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| postal_code    | string     | null: false       | <!-- 4文字目にハイフンが必要>
| prefecture_id  | integer    | null: false       |
| city           | string     | null: false       |
| address        | string     | null: false       |
| building       | string     |                   |
| phone_number   | string     | null: false       | <!-- 半角英数字11桁以内>
| order          | references | foreign_key: true |

### Association

- belongs_to :order

<!-- *** >
<!-- 購入機能実装 >
<!-- 実装予定のモデル（テーブル）名を一部変更して実装しました。（README反映済） >
<!-- 旧：buyer_table → 新：order_table >
<!-- 旧：order_table → 新：purchaser_table >

<!-- phone_numberのバリデーションを変更しました >
<!-- 旧：9字以上 → 新：11字以内 >
<!-- *** >
