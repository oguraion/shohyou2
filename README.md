# README

## アプリケーション概要

- 技術書のレビューアプリ


## アプリケーションの機能一覧

- ユーザー新規登録機能
- ユーザーログイン／ログアウト機能
- ユーザー情報編集機能
- マイページ表示機能
- プロフィール表示機能
- 技術書登録／編集機能
- レビュー登録／削除機能
- 本の状態登録／編集／削除機能

## アプリケーション内で使用している技術一覧
|種別|名称|
|------|----|
|開発言語|Ruby(ver 2.5.1)|
|フレームワーク|Ruby on Rails(ver 5.2.1)|
|マークアップ|HTML(Haml),CSS(Sass)|
|フロントエンド|JavaScript(jQuery)|
|DB|MySQL|
|本番環境|AWS EC2|
|Webサーバー|Nginx|
|applicationサーバー|Unicorn|
|画像アップロード|carrierwave, AWS S3|
|自動デプロイ|capistrano|
|ユーザー管理|devise|

## データベース

### usersテーブル

|Column|Type|Options|
|------|----|-------|
|email|string|null: false,  limit: 100, default: ""|
|encrypted_password|string|null: false, default: ""|
|reset_password_token|string|null: false|
|reset_password_sent_at|datetime|null: false|
|remember_created_at|datetime|null: false|
|nickname|string|null: false,limit: 15|
|area|integer|limit: 2|
|birthday|date||
|image|text||
|introduction|text|limit:1000|

#### Association
- has_many :lists
- has_many :books, thorough: :lists
- has_many :reviews
- has_many :users, through: :reviews

#### add_index
- add_index :email, unique: true
- add_index :reset_password_token, unique: true


### booksテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: :true, limit: :50||
|author|string|null: false, limit: 20|
|page|integer||
|image|text||
|description|string|limit: 1000|
|genre|references|foreign_key: true|

#### Association
- has_one :genre
- has_many :lists
- has_many :users, through: :lists
- has_many :reviews
- has_many :users, through: :reviews


### listsテーブル

|Column|Type|Options|
|------|----|-------|
|status|integer|null: false, length: 1|
|user_id|references|null: false, foreign_key: true|
|book_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :book


### reviewsテーブル

|Column|Type|Options|
|------|----|-------|
|day|date||
|comment|text|limit: 10000|
|user_id|references|null: false, foreign_key: true|
|book_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :book


### sending_methodsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

#### Association
- has_many :products


### areasテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

#### index
- add_index :name, unique: true, length: 10


### genresテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

#### index
- add_index :name, unique: true, length: 10


## ER図
https://www.lucidchart.com/invitations/accept/feaf9271-6798-45d4-adc3-d4819001dec7

#### まだ実装していない機能等あります。そのためER図の表記と上記テーブルとは相違があるものもあります。随時実装予定となります。
