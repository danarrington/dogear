require 'spec_helper'

describe BooksController do

  describe 'POST #create' do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end
    it 'sets started at to today' do
      post :create, book: attributes_for(:book)
      expect(Book.first.started_at).to eq Date.today
    end

    it 'sets the logged in user as user' do
      post :create, book: attributes_for(:book)
      expect(Book.first.user).to eq @user
    end
  end

  describe 'GET #show' do
    it 'assigns the requested book to @book' do
      book = create(:book)
      get :show, id: book
      expect(assigns(:book)).to eq book
    end
    it 'renders the show template' do
      book = create(:book)
      get :show, id: book
      expect(response).to render_template :show
    end
  end

  describe 'POST #update' do
    context 'with a valid page number' do
      it 'saves a new bookmark to the database' do
        book = create(:book)
        expect{
          patch :update, id: book, book: attributes_for(:book)
        }.to change(Bookmark, :count).by 1
      end
    end
    context 'without a valid page number' do
      it 'does not save a new bookmark to the database' do
        pending 'not sure how to process validation yet'
        book = create(:book)
        expect {
          patch :update, id: book, book: attributes_for(:invalid_book)
        }.to_not change(Bookmark, :count)
      end
    end
  end

  describe 'GET #index' do
    context 'with signed in user' do
      before :each do
        @user = create(:user)
        session[:user_id] = @user.id
      end
      it 'only lists signed in users books' do
        user_book = create(:book, user: @user)
        other_user = create(:user)
        other_book = create(:book, user: other_user)

        get :index
        expect(assigns(:books)).to match_array([user_book])
      end
    end
  end

end
