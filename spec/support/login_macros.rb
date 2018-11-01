# frozen_string_literal: true

module LoginMacros
  # rubocop:disable Naming/AccessorMethodName
  def set_user_token(user)
    cookies[:auth_token] = user.auth_token
    user
  end
  # rubocop:enable Naming/AccessorMethodName

  def sign_in(user)
    visit root_path

    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
