require 'spec_helper'

describe UsersController do

  describe 'POST #create' do
    it 'sets the email address of the new user' do
      email = Faker::Internet.email
      post :create, user: attributes_for(:user, email: email)
      expect(User.first.email).to eq email
    end

    it 'signs in the new user' do
      post :create, user: attributes_for(:user)
      expect(session[:user_id]).to_not be_nil
    end
  end
end