class Book < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true
  validates :pages, presence: true


  def pace
    days = (Date.today - started_at.to_date).to_f
    (current_page/days).round(1)
  end

  def finish_date
    started_at.to_date + (pages.to_f/current_page*(Date.today-started_at.to_date)).to_i if current_page > 0
  end

  def finish_date_days
    (finish_date - Date.today).to_i if finish_date
  end
end
