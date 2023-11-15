# テーブル設計

## usersテーブル

| Column             | Type       | Option                    |
| ------------------ | ---------- | ------------------------- |
| nickname           | string     | null: false               |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |
| name               | string     | null: false               |
| furigana           | string     | null: false               |
| date_of_birth      | integer    | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## itemsテーブル

| Column          | Type       | Option                         |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| category        | string     | null: false                    |
| situation       | string     | null: false                    |
| delivery_charge | string     | null: false                    |
| region          | string     | null: false                    |
| number_of_days  | string     | null: false                    |
| price           | integer    | null: false                    |
| user_id         | references | null: false, foreign_key: true |

### Association

- has_one :purchase_record
- belongs_to :user

## shipping_adressテーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| post_code          | integer    | null: false                    |
| prefectures        | string     | null: false                    |
| municipalities     | string     | null: false                    |
| street_address     | string     | null: false                    |
| building_name      | string     |                                |
| telephone_number   | integer    | null: false                    |
| purchase_record_id | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record

## purchase_recordテーブル

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_adress