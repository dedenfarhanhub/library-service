# frozen_string_literal: true

# == Schema Information
#
# Table name: loans
#
#  id          :bigint           not null, primary key
#  book_id     :bigint
#  borrower_id :bigint
#  due_date    :datetime
#  returned_at :datetime
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Loan < ActiveRecord::Base
  belongs_to :book
  belongs_to :borrower

  validates :borrowed_at, :due_date, presence: true

  def returned?
    !!returned_at
  end

  def late?
    returned_at.present? && returned_at > due_date
  end

  def duration_limit?(due_date)
    due_date.to_date - Date.today.to_date > ENV['MAX_LOAN_DURATION'].to_i
  end

  def status
    return 'returned_late' if late?
    return 'returned' if returned?
    return 'overdue' if due_date < Time.now
    'borrowed'
  end

  def as_json(options = {})
    {
      id: id,
      book: book.as_json,
      borrower: borrower.as_json,
      borrowed_at: borrowed_at,
      due_date: due_date,
      returned_at: returned_at,
      status: status
    }
  end
end
