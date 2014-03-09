require 'spec_helper'

describe SessionsController do

  describe 'POST #create' do

    let (:user) { create(:user, email: 'dan@gmail.com') }

    it 'should sign the user in' do
      post :create, signin: {email: user.email, password: user.password}

      expect(session[:user_id]).to_not be_nil
    end

    it 'should ignore whitespace in email' do
      post :create, signin: {email: "#{user.email} ", password:user.password}

      expect(session[:user_id]).to_not be_nil
    end

    it 'should ignore email case' do
      post :create, signin: {email: 'DAN@gmail.com', password:user.password}

      expect(session[:user_id]).to_not be_nil
    end
  end
end