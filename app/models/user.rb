# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  before_create { generate_token }
  def generate_token
    loop do
      self.auth_token = SecureRandom.urlsafe_base64
      break unless User.exists?(auth_token: auth_token)
    end
  end
end
