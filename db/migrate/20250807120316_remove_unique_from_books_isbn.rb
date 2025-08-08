class RemoveUniqueFromBooksIsbn < ActiveRecord::Migration[7.2]
  def change
    remove_index :books, column: :isbn
    add_index :books, :isbn
  end
end
