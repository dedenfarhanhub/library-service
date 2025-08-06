# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn, unique: true
      t.integer :stock, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :books, :isbn, unique: true
    add_index :books, :deleted_at
  end
end
