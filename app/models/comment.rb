class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment , length: {minimum: 2}





end
