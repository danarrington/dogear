require 'spec_helper'

describe Book do
  it 'is valid with title, pages and current_page' do
    expect(build(:book)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:book, title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without pages' do
    expect(build(:book, pages: nil, title: 'book title')).to have(1).errors_on(:pages)
  end

  context 'with some reading data' do
    it 'calculates the pace correctly' do
      book = create(:book, started_at: 7.days.ago.to_date, current_page: 140)

      expect(book.pace).to eq 20
    end

    it 'calculates the finish date correctly' do
      book = create(:book, started_at: 7.days.ago.to_date, current_page: 100, pages: 300)

      expect(book.finish_date).to eq 14.days.from_now.to_date
    end
  end

  context 'that is not a kindle book' do
    it 'returns current page as adjusted_current_page' do
      book = create(:book, current_page: 50, pages: 200, kindle: false)

      expect(book.adjusted_current_page).to eq 50
    end
  end

  context 'that is a kindle book' do
    it 'returns page not percent as adjusted_current_page' do
      book = create(:book, current_page: 50, pages: 200, kindle: true)

      expect(book.adjusted_current_page).to eq 100 #50% of 200 is 100
    end
  end
end
