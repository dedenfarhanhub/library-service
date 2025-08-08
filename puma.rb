# frozen_string_literal: true
require 'dotenv/load'

port ENV.fetch("APP_PORT") { 4567 }

environment ENV.fetch("RACK_ENV") { "development" }

workers ENV.fetch("WEB_CONCURRENCY") { 1 }

threads_count = ENV.fetch("MAX_THREADS") { 5 }
threads threads_count, threads_count

preload_app!

plugin :tmp_restart
