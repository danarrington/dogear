# frozen_string_literal: true

module BooksHelper
  def page_placeholder(book)
    if book.kindle?
      book.current_page.to_s + '%'
    else
      book.current_page
    end
  end
end
