class Book < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, length: { maximum: 50,  too_long: 'は50文字以内で記入してください'}, presence: true, uniqueness: true
  validates :author, length: { maximum: 20, too_long: 'は50文字以内で記入してください'}, presence: true
  validates :page, length: { maximum: 11, too_long: 'の桁が大きすぎます'}, numericality: :only_integer, numericality: { allow_blank: true }
  validates :discription, length: { maximum: 1000, too_long: 'は1000文字以内で記入してください'}

  has_one :genre
  has_many :lists
  has_many :users, through: :lists
  has_many :reviews
  has_many :users, through: :reviews
end
