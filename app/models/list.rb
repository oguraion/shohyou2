class List < ApplicationRecord

  validates :status, inclusion: {in: [0, 1, 2]}
  validates_uniqueness_of :user_id, scope: :book_id

  belongs_to :user
  belongs_to :book
end
