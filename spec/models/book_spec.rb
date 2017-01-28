require 'rails_helper'

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

  it 'is invalid without current_page' do
    expect(build(:book, current_page: nil)).to have(1).errors_on(:current_page)
  end

  context 'with some reading data' do
    subject(:book) {create(:book, started_at: 1.hour.ago, current_page: 10, pages: 100, kindle:false)}
    it 'calculates days discreetly' do
      expect(book.pace).to eq 10
    end

    it 'calculates days_reading discreetly' do
      expect(book.days_reading).to eq 1
    end
  end

  context 'that was just started' do
    subject(:book) {create(:book, started_at: 1.hour.ago, current_page: 10, pages: 100, kindle:false)}
    it 'calculates finish date discreetly' do
      expect(book.finish_date).to eq 9.days.from_now.to_date
    end
  end

  context 'that is not a kindle book' do
    subject(:book)  {create(:book, started_at: 5.days.ago+1.hour, current_page: 100, pages: 300, kindle: false)}

    its(:pace) { should eq 20 }

    its(:finish_date) {should eq 10.days.from_now.to_date}

    its(:adjusted_current_page) {should eq 100}
  end

  context 'that is a kindle book' do
    subject(:book) {create(:book, started_at: 5.days.ago+1.hour, current_page: 50, pages: 300, kindle: true)}

    it 'calculates the pace correctly' do
      expect(book.pace).to eq 30
    end

    it 'calculates the finish date correctly' do
      expect(book.finish_date).to eq 5.days.from_now.to_date
    end

    it 'returns page not percent as adjusted_current_page' do
      expect(book.adjusted_current_page).to eq 150 #50% of 300 is 150
    end
  end

  context 'that is finished' do
    subject(:book) {create(:book, started_at: 50.days.ago+1.hour, current_page: 300, pages: 300, finished: true)}
    let!(:last_bookmark) {create(:bookmark, book: book, page: 300, created_at: 40.days.ago)}

    it 'should pass' do
      expect(book.pace).to eq 30
    end

  end
end
