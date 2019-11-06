class Review < ApplicationRecord

  validates :comment, length: { maximum: 2000,  too_long: 'は2000文字以内で記入してください'}

  belongs_to :user
  belongs_to :book
end
