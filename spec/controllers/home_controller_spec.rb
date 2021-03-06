# frozen_string_literal: true

require 'rails_helper'

describe HomeController do
  describe "GET 'index'" do
    context 'with logged in user' do
      before :each do
        @user = set_user_token(create(:user))
      end
      context 'with started book' do
        it 'redirects to most recently read book' do
          create(:book, user: @user, updated_at: 5.days.ago)
          new_book = create(:book, user: @user, updated_at: 1.days.ago)
          get :index

          expect(response).to redirect_to new_book
        end
      end
      context 'without a started book' do
        it 'renders the book listing page' do
          get :index
          expect(response).to redirect_to books_path
        end
      end
    end
    context 'not logged in' do
      it 'renders index' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
