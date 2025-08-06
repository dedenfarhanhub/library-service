# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  isbn       :string(255)
#  stock      :integer          default(0)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Book < ActiveRecord::Base
  has_many :loans

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def as_json(options = {})
    super(only: [:id, :title, :isbn, :stock])
  end
end
