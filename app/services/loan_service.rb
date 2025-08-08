# frozen_string_literal: true

class LoanService
  MAX_LOAN_DAYS = ENV.fetch('MAX_LOAN_DURATION_DAYS').to_i

  def self.get_all_loans
    LoanRepository.all
  end

  def self.get_loan(id)
    LoanRepository.find(id)
  end

  def self.create_loan(book_id:, borrower_id:, due_date:)
    raise "Missing book_id" if book_id.nil?
    raise "Missing borrower_id" if borrower_id.nil?
    raise "Missing due_date" if due_date.nil?

    book = BookRepository.find(book_id)
    raise "Book is out of stock" if book.stock <= 0

    borrower = BorrowerRepository.find(borrower_id)

    active_loan = LoanRepository.active_loan_for_borrower(borrower_id)
    raise "Borrower already has an active loan" if active_loan

    due = DateTime.parse(due_date)
    raise "Loan duration exceeds 30 days" if (due.to_date - Date.today).to_i > MAX_LOAN_DAYS

    # Decrease stock
    BookRepository.update(book, stock: book.stock - 1)

    LoanRepository.create(book: book, borrower: borrower, due_date: due)
  end

  def self.return_loan(id)
    loan = LoanRepository.find(id)
    raise "Loan already returned" if loan.returned_at

    loan = LoanRepository.return(loan)

    # Return stock
    book = loan.book
    BookRepository.update(book, stock: book.stock + 1)

    loan
  end

  def self.soft_delete_loan(id)
    loan = LoanRepository.find(id)
    LoanRepository.delete(loan)
  end
end
