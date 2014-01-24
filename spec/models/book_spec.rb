require 'spec_helper'

describe Book do
  it 'is valid with title, pages and current_page' do
    book = Book.new(title: 'A book', pages: 105, current_page: 0)
    expect(book).to be_valid
  end

  it 'is invalid without a title' do
    expect(Book.new(title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without pages' do
    expect(Book.new(pages: nil, title: 'book title')).to have(1).errors_on(:pages)
  end


end
