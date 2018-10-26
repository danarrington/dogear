# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.integer :pages
      t.integer :current_page

      t.timestamps
    end
  end
end
