# README

## DB

### users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birth_date         | date   | null: false               |

#### Association

- has_many :items
- has_many :orders
- has_many :comments

### items テーブル

| Column                | Type       | Options                                      |
| --------------------- | ---------- | -------------------------------------------- |
| user                  | references | null: false, foreign_key: true               |
| name                  | string     | null: false                                  |
| info                  | text       | null: false                                  |
| category_id           | integer    | null: false, ActiveHash                      |
| sales_status_id       | integer    | null: false, ActiveHash                      |
| shipping_fee_id       | integer    | null: false, ActiveHash                      |
| prefecture_id         | integer    | null: false, ActiveHash                      |
| scheduled_delivery_id | integer    | null: false, ActiveHash                      |
| price                 | integer    | null: false, minimum: 300, maximum:9,999,999 |

#### Association

##### DB

- belongs_to :user
- has_one :order
- has_many :comments

##### ActiveHash

- belongs_to :category
- belongs_to :sales_status
- belongs_to :shipping_fee
- belongs_to :prefecture
- belongs_to :scheduled_delivery

### orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :item
- has_one :destination

### destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false, maximum: 8        |
| prefecture_id | integer    | null: false, ActiveHash        |
| city          | string     | null: false                    |
| addresses     | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

#### Association

##### DB

- belongs_to :order

##### ActiveHash

- belongs_to :prefecture

### comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

#### Association

- has_many :users
- has_many :items

## ActiveHash

### category Hash

| id  | data                     |
| --- | ------------------------ |
| 0   | ---                      |
| 1   | レディース               |
| 2   | メンズ                   |
| 3   | ベビー・キッズ           |
| 4   | インテリア・住まい・小物 |
| 5   | 本・音楽・ゲーム         |
| 6   | おもちゃ・ホビー・グッズ |
| 7   | 家電・スマホ・カメラ     |
| 8   | スポーツ・レジャー       |
| 9   | ハンドメイド             |
| 10  | その他                   |

#### Association

- has_many :items

### sales_status Hash

| id  | data                 |
| --- | -------------------- |
| 0   | ---                  |
| 1   | 新品・未使用         |
| 2   | 未使用に近い         |
| 3   | 目立った傷や汚れなし |
| 4   | やや傷や汚れあり     |
| 5   | 傷や汚れあり         |
| 6   | 全体的に状態が悪い   |

#### Association

- has_many :items

### shipping_fee Hash

| id  | data                 |
| --- | -------------------- |
| 0   | ---                  |
| 1   | 着払い(購入者負担)   |
| 2   | 送料込み(出品者負担) |

#### Association

- has_many :items

### prefecture Hash

| id  | data     |
| --- | -------- |
| 0   | ---      |
| 1   | 北海道   |
| 2   | 青森県   |
| 3   | 岩手県   |
| 4   | 宮城県   |
| 5   | 秋田県   |
| 6   | 山形県   |
| 7   | 福島県   |
| 8   | 茨城県   |
| 9   | 栃木県   |
| 10  | 群馬県   |
| 11  | 埼玉県   |
| 12  | 千葉県   |
| 13  | 東京都   |
| 14  | 神奈川県 |
| 15  | 新潟県   |
| 16  | 富山県   |
| 17  | 石川県   |
| 18  | 福井県   |
| 19  | 山梨県   |
| 20  | 長野県   |
| 21  | 岐阜県   |
| 22  | 静岡県   |
| 23  | 愛知県   |
| 24  | 三重県   |
| 25  | 滋賀県   |
| 26  | 京都府   |
| 27  | 大阪府   |
| 28  | 兵庫県   |
| 29  | 奈良県   |
| 30  | 和歌山県 |
| 31  | 鳥取県   |
| 32  | 島根県   |
| 33  | 岡山県   |
| 34  | 広島県   |
| 35  | 山口県   |
| 36  | 徳島県   |
| 37  | 香川県   |
| 38  | 愛媛県   |
| 39  | 高知県   |
| 40  | 福岡県   |
| 41  | 佐賀県   |
| 42  | 長崎県   |
| 43  | 熊本県   |
| 44  | 大分県   |
| 45  | 宮崎県   |
| 46  | 鹿児島県 |
| 47  | 沖縄県   |

#### Association

- has_many :items
- has_many :orders

### scheduled_delivery Hash

| id  | data         |
| --- | ------------ |
| 0   | ---          |
| 1   | 1~2 日で発送 |
| 2   | 2~3 日で発送 |
| 3   | 4~7 日で発送 |

#### Association

- has_many :items
