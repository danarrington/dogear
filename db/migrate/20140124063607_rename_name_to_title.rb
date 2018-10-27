# frozen_string_literal: true

class RenameNameToTitle < ActiveRecord::Migration
  def change
    rename_column :books, :name, :title
  end
end
