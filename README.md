# テーブル設計

## usersテーブル

| Column              | Type   | Option                    |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_furigana  | string | null: false               |
| first_name_furigana | string | null: false               |
| date_of_birth       | date   | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## itemsテーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| delivery_charge_id | integer    | null: false                    |
| region_id          | integer    | null: false                    |
| delivery_day_id    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- has_one :purchase_record
- belongs_to :user

## shipping_addressesテーブル

| Column           | Type       | Option                         |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| prefectures_id   | integer    | null: false                    |
| municipalities   | string     | null: false                    |
| street_address   | string     | null: false                    |
| building_name    | string     |                                |
| telephone_number | string     | null: false                    |
| purchase_record  | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record

## purchase_recordsテーブル

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address