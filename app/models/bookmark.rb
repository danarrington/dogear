class Bookmark < ActiveRecord::Base
  belongs_to :book

  validates :page, presence: true, numericality: true
end