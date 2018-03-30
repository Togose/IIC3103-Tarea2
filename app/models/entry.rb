class Entry < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :subhead, length: {maximum: 200}


end
