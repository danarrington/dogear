class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :pages, presence: true
end
