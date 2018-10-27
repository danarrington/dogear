# frozen_string_literal: true

class AddKindleToBooks < ActiveRecord::Migration
  def change
    add_column :books, :kindle, :boolean, default: false
  end
end
