class Entry < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :subtitle, length: {maximum: 200}, presence: false
  validates :body, presence: true

  def cut
    if self.body.length >= 500
      last_space = self.body[0..500].rindex(' ') - 1
      self.body = self.body[0..last_space] + '...'
    else
      self.body = self.body[0..497] + '...'
    end
  end

  def self.GetAll
    output = all.select(:id, :title, :subtitle, :body, :created_at, :updated_at)
  end

  def self.GetWithId id
    output = where(id: id).select(:id, :title, :subtitle, :body, :created_at, :updated_at)
  end
end
