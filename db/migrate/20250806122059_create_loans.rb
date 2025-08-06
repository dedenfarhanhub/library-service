class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.references :book, foreign_key: true
      t.references :borrower, foreign_key: true
      t.datetime :due_date
      t.datetime :returned_at

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :loans, :deleted_at
  end
end
