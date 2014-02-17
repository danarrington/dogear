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


end
