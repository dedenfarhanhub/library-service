require 'dotenv/load'
require 'active_record'
require 'yaml'
require 'erb'
require 'bundler/setup'

env = ENV['APP_ENV'] || 'development'

# Load and parse database.yml with ERB
db_config_file = File.expand_path('../database.yml', __FILE__)
raw_config = File.read(db_config_file)
erb_config = ERB.new(raw_config).result
db_config = YAML.safe_load(erb_config, aliases: true)

Bundler.require
ActiveRecord::Base.establish_connection(db_config[env])
