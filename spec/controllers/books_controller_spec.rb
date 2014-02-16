require 'spec_helper'

describe BooksController do

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
    it 'assigns the '
  end

end
