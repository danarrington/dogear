class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :book
      t.integer :page

      t.timestamps
    end
  end
end
