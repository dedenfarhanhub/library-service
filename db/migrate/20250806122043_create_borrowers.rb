class CreateBorrowers < ActiveRecord::Migration[7.2]
  def change
    create_table :borrowers do |t|
      t.string :id_card_number
      t.string :name
      t.string :email

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :borrowers, :id_card_number
    add_index :borrowers, :email
    add_index :borrowers, :deleted_at
  end
end
