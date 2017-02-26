class Book < ApplicationRecord

  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true
  validates :pages, presence: true
  validates :current_page, presence: true
  validates :user, presence: true

  def pace
    last_day = finished? ? bookmarks.last.created_at : Time.now.utc
    days = ((last_day - started_at)/1.day).ceil.to_f
    (adjusted_current_page/days).round(1)
  end

  def finish_date
    return nil if current_page == 0

    pages_left = pages - adjusted_current_page
    days_left = pages_left.to_f/pace
    Date.current.in_time_zone + days_left.days
  end

  def days_reading
    (Time.now.utc.to_date - (started_at.to_date-1.day)).to_i
  end

  def finish_date_days
    (finish_date.to_date - Date.current.in_time_zone.to_date).round if finish_date
  end

  def adjusted_current_page
    if kindle? && finished?
      pages
    else
      kindle? ? (current_page.to_f/100 * pages).to_i : current_page
    end
  end

  def started_short
    started_at.utc.to_date.strftime('%b %d')
  end

  def finished_short
    bookmarks.last.created_at.utc.to_date.strftime('%b %d')
  end

  def bookmark_graph_data
    bookmarks.group_by_day(:created_at, series: false).maximum(:page)
  end
end
