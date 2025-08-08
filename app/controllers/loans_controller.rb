# frozen_string_literal: true

class LoansController
  def self.index
    loans = LoanService.get_all_loans
    [200, loans.to_json]
  end

  def self.create(params)
    begin
      loan = LoanService.create_loan(
        book_id: params['book_id'],
        borrower_id: params['borrower_id'],
        due_date: params['due_date']
      )
      [201, loan.to_json]
    rescue => e
      [422, { error: e.message }.to_json]
    end
  end

  def self.return(id)
    begin
      loan = LoanService.return_loan(id)
      [200, loan.to_json]
    rescue => e
      [422, { error: e.message }.to_json]
    end
  end

  def self.show(id)
    begin
      loan = LoanService.get_loan(id)
      [200, loan.to_json]
    rescue => e
      [404, { error: e.message }.to_json]
    end
  end

  def self.destroy(id)
    begin
      LoanService.soft_delete_loan(id)
      [200, nil]
    rescue => e
      [404, { error: e.message }.to_json]
    end
  end
end
