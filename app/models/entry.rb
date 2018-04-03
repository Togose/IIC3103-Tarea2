class Entry < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :subtitle, length: {maximum: 200}, presence: false


  def self.GetAll
    output = all.select(:id, :title, :subtitle, :body, :created_at, :updated_at)
  end

  def self.GetWithId id
    output = where(id: id).select(:id, :title, :subtitle, :body, :created_at, :updated_at)
  end
end
