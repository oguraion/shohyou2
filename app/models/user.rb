class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  mount_uploader :image, ImageUploader

  validates :nickname, length: { in: 1..15, message: 'は1〜15文字で記入してください'}, presence: true
  validates :email, length: { maximum: 50, too_long: 'は50文字以内で記入してください'}, presence: true, format: { with: /\A\S+@\S+\.\S+\z/, message: "は「***@***.***」で登録してください"}

  has_many :lists
  has_many :books, through: :lists
  has_many :reviews
  has_many :books, through: :reviews
end
