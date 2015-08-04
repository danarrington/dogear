require 'spec_helper'

describe BooksController do

  describe 'POST #create' do
    let!(:user) {set_user_token(create(:user))}
    subject(:book) {Book.first}
    before :each do
      post :create, book: attributes_for(:book)
    end

    its(:started_at) {should eq Date.today}

    its(:user) {should eq user}

    its(:current_page) {should eq 0}
  end

  describe 'GET #show' do
    before :each do
      @book = create(:book, finished: finished)
      get :show, id: @book
    end

    context 'with an open book' do
      let(:finished) {false}
      it 'assigns the requested book to @book' do
        expect(assigns(:book)).to eq @book
      end
      it 'renders the show template' do
        expect(response).to render_template :show
      end
    end
    context 'with a finished book' do
      let!(:finished) {true}
      it 'renders the show_finished template' do
        expect(response).to render_template :show_finished
      end
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
        cookies[:auth_token] = @user.auth_token
      end
      it 'only lists signed in users books' do
        user_book = create(:book, user: @user)
        other_user = create(:user)
        other_book = create(:book, user: other_user)

        get :index
        expect(assigns(:books)).to match_array([user_book])
      end
      context 'with open and finished books' do
        before :each do
          @open_book = create(:book, user:@user)
          @closed_book = create(:book, user:@user, finished:true)
          get :index
        end
        it 'lists open books' do
          expect(assigns(:books)).to match_array([@open_book])
        end
        it 'lists finished books' do
          expect(assigns(:finished_books)).to match_array([@closed_book])
        end
      end
    end
  end

  describe 'POST #finish' do
    let(:book) { create(:book, finished: false)}

    it 'sets finished to true' do
      patch :finish, id: book

      book.reload
      expect(book.finished).to eq true
    end

    it 'redirects to show' do
      patch :finish, id: book
      expect(response).to redirect_to book
    end
  end

  describe 'PATCH #reopen' do
    let(:book) { create(:book, finished: true)}

    it 'sets finished to false' do
      patch :reopen, id: book

      book.reload
      expect(book.finished).to eq false
    end

    it 'redirects to show' do
      patch :reopen, id: book
      expect(response).to redirect_to book
    end
  end
end
