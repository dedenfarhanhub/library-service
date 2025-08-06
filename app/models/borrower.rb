# frozen_string_literal: true

# == Schema Information
#
# Table name: borrowers
#
#  id             :bigint           not null, primary key
#  id_card_number :string(255)
#  name           :string(255)
#  email          :string(255)
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Borrower < ActiveRecord::Base
  has_many :loans

  validates :id_card_number, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def as_json(options = {})
    super(only: [:id, :id_card_number, :name, :email])
  end
end
