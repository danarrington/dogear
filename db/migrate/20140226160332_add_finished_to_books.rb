class AddFinishedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :finished, :boolean, default: false
  end
end
