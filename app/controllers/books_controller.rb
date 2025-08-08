# frozen_string_literal: true

class BooksController
  def self.index
    books = BookService.get_all_books
    [200, books.to_json]
  end

  def self.create(params)
    begin
      book = BookService.create_book(
        title: params['title'],
        isbn: params['isbn'],
        stock: params['stock'].to_i
      )
      [200, book.to_json]
    rescue => e
      [422, { error: e.message }.to_json]
    end
  end

  def self.show(id)
    begin
      book = BookService.get_book(id)
      [200, book.to_json]
    rescue => e
      [404, { error: e.message }.to_json]
    end
  end


  def self.update(id, params)
    begin
      book = BookService.update_book(
        id: id,
        attributes: {
          title: params['title'],
          isbn: params['isbn'],
          stock: params['stock']&.to_i
        }
      )
      [200, book.to_json]
    rescue => e
      [422, { error: e.message }.to_json]
    end
  end

  def self.destroy(id)
    begin
      BookService.soft_delete_book(id)
      [200, nil]
    rescue => e
      [404, { error: e.message }.to_json]
    end
  end
end
