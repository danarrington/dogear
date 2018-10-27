# frozen_string_literal: true

class Stats
  def self.total_pages(user)
    count = 0
    Book.where(user: user).each do |b|
      count += b.adjusted_current_page
    end
    count
  end

  def self.finished_books(user)
    Book.where(user: user, finished: true).count
  end
end
