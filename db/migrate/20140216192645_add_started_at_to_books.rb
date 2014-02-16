class AddStartedAtToBooks < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.datetime :started_at
    end
  end
end
