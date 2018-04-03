class Comment < ApplicationRecord
  belongs_to :entry, optional: true
  validates :author, presence: true
  validates :comment, presence: true

  def self.GetAll
    output = all.select(:id, :author, :comment, :created_at)
  end

  def self.GetWithEntryId entry_id
    output = where(entry_id: entry_id).select(:id, :author, :comment, :created_at)
  end

  def self.GetWithId id
    #output = where(entry_id: id).where(id: id).select(:id, :author_name,:body, :created_at)
    output = where(id: id).select(:id, :author, :comment, :created_at)
  end


end
