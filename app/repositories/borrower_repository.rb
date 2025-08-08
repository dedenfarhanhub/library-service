# frozen_string_literal: true

class BorrowerRepository
  def self.all
    Borrower.all.order(:created_at)
  end

  def self.find(id)
    borrower = Borrower.find_by(id: id)
    raise "Borrower not found" unless borrower
    borrower
  end

  def self.create(id_card_number:, name:, email:)
    Borrower.create!(id_card_number: id_card_number, name: name, email: email)
  end

  def self.update(existing_borrower, attributes)
    existing_borrower.update!(attributes)
    existing_borrower
  end

  def self.delete(existing_borrower)
    existing_borrower.destroy if existing_borrower
    existing_borrower
  end

  def self.find_by_id_card_number(id_card_number)
    Borrower.where(id_card_number: id_card_number).first
  end

  def self.find_by_email(email)
    Borrower.where(email: email).first
  end
end
