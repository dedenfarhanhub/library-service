# frozen_string_literal: true
require_relative './config/environment'

class App < Sinatra::Base
  run! if app_file == $0
end
