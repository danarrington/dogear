# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'MyString'
    email Faker::Internet.email
    password_digest 'MyString'
    password 'password'
    password_confirmation 'password'
  end
end
