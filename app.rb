# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require_relative './config/environment'

Dir[File.join(__dir__, 'app/**/*.rb')].each { |file| require file }

class App < Sinatra::Base
  use Rack::Cors do
    allow do
      origins '*' # for development
      resource '*',
               headers: :any,
               methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end

  before do
    if request.media_type == 'application/json'
      request.body.rewind
      body = request.body.read
      params.merge!(JSON.parse(body)) unless body.empty?
    end
  end

  before do
    content_type :json
  end

  # --- BOOK ROUTES ---
  get '/books' do
    BooksController.index
  end

  post '/books' do
    BooksController.create(params)
  end

  get '/books/:id' do
    BooksController.show(params[:id])
  end

  put '/books/:id' do
    BooksController.update(params[:id], params)
  end

  delete '/books/:id' do
    BooksController.destroy(params[:id])
  end

  # --- BORROWER ROUTES ---
  get '/borrowers' do
    BorrowersController.index
  end

  post '/borrowers' do
    BorrowersController.create(params)
  end

  get '/borrowers/:id' do
    BorrowersController.show(params[:id])
  end

  put '/borrowers/:id' do
    BorrowersController.update(params[:id], params)
  end

  delete '/borrowers/:id' do
    BorrowersController.destroy(params[:id])
  end

  # --- LOAN ROUTES ---
  get '/loans' do
    LoansController.index
  end

  get '/loans/:id' do
    LoansController.show(params[:id])
  end

  post '/loans' do
    LoansController.create(params)
  end

  patch '/loans/:id/return' do
    LoansController.return(params[:id])
  end

  get '/' do
    { message: 'Library Loan API is running' }.to_json
  end

  run! if app_file == $0
end
