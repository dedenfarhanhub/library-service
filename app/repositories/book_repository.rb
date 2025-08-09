# frozen_string_literal: true

class BookRepository
  def self.all
    Book.all.order(:created_at)
  end

  def self.find(id)
    book = Book.find_by(id: id)
    raise "Book not found" unless book
    book
  end

  def self.create(title:, isbn:, stock:)
    Book.create!(title: title, isbn: isbn, stock: stock)
  end

  def self.update(existing_book, attributes)
    existing_book.update!(attributes) if existing_book
    existing_book
  end

  def self.delete(existing_book)
    existing_book.destroy if existing_book
    existing_book
  end
  def self.find_by_isbn_with_lock(isbn)
    Book.where(isbn: isbn, deleted_at: nil).lock(true).first
  end
  def self.transaction(&block)
    Book.transaction(&block)
  end
end
