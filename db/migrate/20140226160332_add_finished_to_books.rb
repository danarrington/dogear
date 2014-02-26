class AddFinishedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :finished, :boolean
  end
end
