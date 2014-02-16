class Book < ActiveRecord::Base

  has_many :bookmarks

  validates :title, presence: true
  validates :pages, presence: true


  def pace
    days = (Date.today - started_at.to_date).to_f
    (current_page/days).round(1)
  end
end
