# frozen_string_literal: true

class BookService
  def self.get_all_books
    BookRepository.all
  end

  def self.create_book(title:, isbn:, stock:)
    raise "Missing title" if title.nil? || title.strip.empty?
    raise "Missing ISBN" if isbn.nil? || isbn.strip.empty?
    raise "Stock must be >= 0" if stock.nil? || stock < 0

    if BookRepository.find_by_isbn(isbn)
      raise "ISBN already exists"
    end

    BookRepository.create(title: title, isbn: isbn, stock: stock)
  end

  def self.get_book(id)
    BookRepository.find(id)
  end

  def self.update_book(id:, attributes:)
    book = BookRepository.find(id)
    raise "Book not found" if book.nil?

    title = attributes[:title]
    isbn = attributes[:isbn]
    stock = attributes[:stock]

    raise "Missing title" if title.nil? || title.strip.empty?
    raise "Missing ISBN" if isbn.nil? || isbn.strip.empty?
    raise "Stock must be >= 0" if stock.nil? || stock < 0

    existing_book = BookRepository.find_by_isbn(isbn)
    if existing_book && existing_book.id != book.id
      raise "ISBN already exists"
    end

    BookRepository.update(book, title: title, isbn: isbn, stock: stock)
  end

  def self.soft_delete_book(id)
    book = BookRepository.find(id)
    raise "Book not found" if book.nil?

    BookRepository.delete(book)
  end
end

