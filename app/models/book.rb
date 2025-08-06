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
  validates :title, :author, presence: true
  validates :isbn, uniqueness: true, allow_blank: true
end
