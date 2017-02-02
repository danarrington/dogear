require 'rails_helper'

describe SessionsController do

  describe 'POST #create' do

    let (:user) { create(:user, email: 'dan@gmail.com') }

    it 'should sign the user in' do
      post :create, params: {signin: {email: user.email, password: user.password}}

      expect(cookies[:auth_token]).to_not be_nil
    end

    it 'should ignore whitespace in email' do
      post :create, params: {signin: {email: "#{user.email} ", password:user.password}}

      expect(cookies[:auth_token]).to_not be_nil
    end

    it 'should ignore email case' do
      post :create, params: {signin: {email: 'DAN@gmail.com', password:user.password}}

      expect(cookies[:auth_token]).to_not be_nil
    end

    context 'with remember me checked' do
      it 'should set the auth cookie' do
        post :create, params: {
          signin: {email: user.email, password: user.password, remember_me: true}
        }

        expect(cookies.permanent[:auth_token]).to eq user.auth_token
      end
    end
  end
end
