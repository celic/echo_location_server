require 'yaml'
require 'point'

dbconfig = YAML::load(File.open('db/test-database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)