# frozen_string_literal: true

require 'rails_helper'

describe Book do
  before { Timecop.freeze }
  after { Timecop.return }

  it 'is valid with title, pages and current_page' do
    expect(build(:book)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:book, title: nil)).to have(1).errors_on(:title)
  end

  it 'is invalid without pages' do
    book = build(:book, pages: nil, title: 'book title')
    expect(book).to have(1).errors_on(:pages)
  end

  it 'is invalid without current_page' do
    book = build(:book, current_page: nil)
    expect(book).to have(1).errors_on(:current_page)
  end

  context 'with some reading data' do
    subject(:book)  do
      create(:book, started_at: 1.hour.ago, current_page: 10, pages: 100,
                    kindle: false)
    end
    it 'calculates days discreetly' do
      expect(book.pace).to eq 10
    end

    it 'calculates days_reading discreetly' do
      expect(book.days_reading).to eq 1
    end
  end

  context 'that was just started' do
    subject(:book) do
      create(:book, started_at: 1.hour.ago, current_page: 10, pages: 100,
                    kindle: false)
    end
    it 'calculates finish date discreetly' do
      expect(book.finish_date).to eq 9.days.from_now.to_date
    end

    it 'calculates finish date days' do
      expect(book.finish_date_days).to eq 9
    end
  end

  context 'that is not a kindle book' do
    subject(:book) do
      create(:book, started_at: 5.days.ago + 1.hour, current_page: 100,
                    pages: 300, kindle: false)
    end

    its(:pace) { should eq 20 }

    its(:finish_date) { should eq 10.days.from_now.to_date }

    its(:adjusted_current_page) { should eq 100 }
  end

  context 'that is a kindle book' do
    subject(:book) do
      create(:book, started_at: 5.days.ago + 1.hour, current_page: 50,
                    pages: 300, kindle: true)
    end

    it 'calculates the pace correctly' do
      expect(book.pace).to eq 30
    end

    it 'calculates the finish date correctly' do
      expect(book.finish_date).to eq 5.days.from_now.to_date
    end

    it 'returns page not percent as adjusted_current_page' do
      expect(book.adjusted_current_page).to eq 150 # 50% of 300 is 150
    end
  end

  context 'that is finished' do
    subject(:book) do
      create(:book, started_at: 50.days.ago + 1.hour, current_page: 300,
                    pages: 300, finished: true)
    end
    let!(:last_bookmark) do
      create(:bookmark, book: book, page: 300, created_at: 40.days.ago)
    end

    it 'should pass' do
      expect(book.pace).to eq 30
    end
  end

  describe '#bookmark_graph_data' do
    context 'with multiple bookmarks on the same day' do
      subject(:book) { create(:book) }
      let!(:earlier_bookmark) do
        create(:bookmark, book: book, page: 5, created_at: 4.hours.ago)
      end
      let!(:later_bookmark) do
        create(:bookmark, book: book, page: 15, created_at: 2.hours.ago)
      end
      it 'only returns the last bookmark' do
        expect(subject.bookmark_graph_data.count).to eq 1
        expect(subject.bookmark_graph_data.first[1]).to eq 15
      end
    end
  end

  describe '::grouped_by_year_for' do
    let(:user) { create(:user) }
    let(:date_2017) { Time.new(2017, 1, 1) }
    let(:date_2018) { Time.new(2018, 1, 1) }
    before do
      create(:book, user: user, finished: true, updated_at: date_2017)
      create(:book, user: user, finished: true, updated_at: date_2017)
      create(:book, user: user, finished: true, updated_at: date_2018)
    end
    subject { Book.grouped_by_year_for(user) }
    it 'groups books by year' do
      expect(subject[2017].count).to eq 2
      expect(subject[2018].count).to eq 1
    end
  end
end
