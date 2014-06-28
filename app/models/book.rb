class Book < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true
  validates :pages, presence: true
  validates :current_page, presence: true
  validates :user, presence: true

  def pace
    days = ((Time.now.utc - started_at)/1.day).ceil.to_f
    (adjusted_current_page/days).round(1)
  end

  def finish_date
    started_at.to_date + (pages.to_f/adjusted_current_page*(Time.now.utc.to_date-started_at.to_date)).to_i if current_page > 0
  end

  def finish_date_days
    (finish_date - Time.now.utc.to_date).round if finish_date
  end

  def adjusted_current_page
    if kindle? && finished?
      pages
    else
      kindle? ? (current_page.to_f/100 * pages).to_i : current_page
    end
  end
end
