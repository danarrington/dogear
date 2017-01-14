class User < ApplicationRecord
  has_secure_password
  before_create { generate_token}
  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end
end
