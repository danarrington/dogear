require 'spec_helper'

describe Stats do

  before :each do
    @user = create(:user)
    create(:book, user: @user, pages: 220, current_page: 200, finished: true)                #200
    create(:book, user: @user, pages:200, current_page: 95, kindle: true, finished:true)     #200
    create(:book, user: @user, pages: 300, current_page: 50, finished: false)                #50
    create(:book, user: @user, pages: 300, current_page: 50, kindle: true, finished: false)  #150
  end
  it 'calculates total pages correctly' do
    expect(Stats.total_pages(@user)).to eq 600
  end


  it 'calculates total finished books' do
    expect(Stats.finished_books(@user)).to eq 2
  end
end