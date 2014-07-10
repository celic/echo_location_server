require 'yaml'
require 'point'
require 'server'

dbconfig = YAML::load(File.open('db/test-database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)