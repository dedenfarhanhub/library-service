# frozen_string_literal: true

class BorrowerService
  def self.get_all_borrowers
    BorrowerRepository.all
  end

  def self.create_borrower(id_card_number:, name:, email:)
    raise "Missing ID card number" if id_card_number.nil? || id_card_number.strip.empty?
    raise "Missing name" if name.nil? || name.strip.empty?
    raise "Missing email" if email.nil? || email.strip.empty?

    if BorrowerRepository.find_by_id_card_number(id_card_number)
      raise "ID card number already exists"
    end

    if BorrowerRepository.find_by_email(email)
      raise "Email already exists"
    end

    BorrowerRepository.create(id_card_number: id_card_number, name: name, email: email)
  end

  def self.get_borrower(id)
    BorrowerRepository.find(id)
  end

  def self.update_borrower(id:, attributes:)
    borrower = BorrowerRepository.find(id)
    raise "Borrower not found" if borrower.nil?

    id_card_number = attributes[:id_card_number]
    name = attributes[:name]
    email = attributes[:email]

    raise "Missing ID card number" if id_card_number.nil? || id_card_number.strip.empty?
    raise "Missing name" if name.nil? || name.strip.empty?
    raise "Missing email" if email.nil? || email.strip.empty?

    existing_by_card = BorrowerRepository.find_by_id_card_number(id_card_number)
    if existing_by_card && existing_by_card.id != borrower.id
      raise "ID card number already exists"
    end

    existing_by_email = BorrowerRepository.find_by_email(email)
    if existing_by_email && existing_by_email.id != borrower.id
      raise "Email already exists"
    end

    BorrowerRepository.update(borrower, id_card_number: id_card_number, name: name, email: email)
  end

  def self.soft_delete_borrower(id)
    borrower = BorrowerRepository.find(id)
    raise "Borrower not found" if borrower.nil?

    BorrowerRepository.delete(borrower)
  end
end
