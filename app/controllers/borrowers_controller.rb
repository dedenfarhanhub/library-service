# frozen_string_literal: true

class BorrowersController
  def self.index
    borrowers = BorrowerService.get_all_borrowers
    [200, borrowers.to_json]
  end

  def self.create(params)
    begin
      borrower = BorrowerService.create_borrower(
        id_card_number: params['id_card_number'],
        name: params['name'],
        email: params['email']
      )
      [200, borrower.to_json]
    rescue => e
      [422, { error: e.message }.to_json]
    end
  end

  def self.show(id)
    begin
      borrower = BorrowerService.get_borrower(id)
      [200, borrower.to_json]
    rescue => e
      [404, { error: e.message }.to_json]
    end
  end

  def self.update(id, params)
    begin
      borrower = BorrowerService.update_borrower(
        id: id,
        attributes: {
          id_card_number: params['id_card_number'],
          name: params['name'],
          email: params['email']
        }
      )
      [200, borrower.to_json]
    rescue => e
      [422, { error: e.message }.to_json]
    end
  end

  def self.destroy(id)
    begin
      BorrowerService.soft_delete_borrower(id)
      [200, nil]
    rescue => e
      [404, { error: e.message }.to_json]
    end
  end
end
