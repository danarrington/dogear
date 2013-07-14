class Book < ActiveRecord::Base
  attr_accessible :current_page, :name, :pages
end
