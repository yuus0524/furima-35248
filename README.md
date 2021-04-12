# テーブル設計

## usersテーブル

| Column             | Type   | Option                    |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :products
- has_many :purchase_records

## productsテーブル

| Column             | Type       | Option                         |
| ---------------    | ---------- | ------------------------------ |
| product_name       | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false, foreign_key: true |
| condition_id       | integer    | null: false, foreign_key: true |
| delivery_burden_id | integer    | null: false, foreign_key: true |
| prefecture_id      | integer    | null: false, foreign_key: true |
| days_to_ship_id    | integer    | null: false, foreign_key: true |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_recordsテーブル

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_address

## shipping_addressesテーブル

| Column          | Type       | Option                         |
| --------------- | ---------- | ------------------------------ |
| post_code       | string     | null: false                    |
| prefecture_id   | integer    | null: false, foreign_key :true |
| city            | string     | null: false                    |
| block           | string     | null: false                    |
| building        | string     |                                |
| phone_number    | integer    | null: false                    |
| purchase_record | references | null: false, foreign_key :true |

### Association

- belongs_to :purchase_record