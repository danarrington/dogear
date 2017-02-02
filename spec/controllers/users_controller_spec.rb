require 'rails_helper'

describe UsersController do

  describe 'POST #create' do
    it 'sets the email address of the new user' do
      email = Faker::Internet.email
      post :create, params: {user: attributes_for(:user, email: email)}
      expect(User.first.email).to eq email
    end

    it 'sets the name of the new user' do
      name = Faker::Name.first_name
      post :create, params: {user: attributes_for(:user, name: name)}
      expect(User.first.name).to eq name
    end
    it 'signs in the new user' do
      post :create, params: {user: attributes_for(:user)}
      expect(cookies[:auth_token]).to_not be_nil
    end

    it 'downcases the email' do
      email = 'UPPER@EMail.com'
      post :create, params: {user: attributes_for(:user, email: email)}
      expect(User.first.email).to eq email.downcase
    end
  end
end
