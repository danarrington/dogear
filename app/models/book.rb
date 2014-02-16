class Book < ActiveRecord::Base

  has_many :bookmarks

  validates :title, presence: true
  validates :pages, presence: true
end
