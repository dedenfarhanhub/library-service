# frozen_string_literal: true

class LoanRepository
  def self.all
    Loan.all.order(created_at: :desc)
  end

  def self.find(id)
    loan = Loan.find_by(id: id)
    raise "Loan not found" unless loan
    loan
  end

  def self.create(book:, borrower:, due_date:)
    Loan.create!(
      book: book,
      borrower: borrower,
      due_date: due_date
    )
  end

  def self.return(loan)
    loan.update!(returned_at: Time.current)
    loan
  end

  def self.delete(loan)
    loan.destroy if loan
    loan
  end

  def self.active_loan_for_borrower(borrower_id)
    Loan.where(
      borrower_id: borrower_id,
      returned_at: nil,
    ).first
  end
end
