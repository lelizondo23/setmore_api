require 'net/http'
require 'json'
require 'date'

path = File.join(File.expand_path(File.dirname(__FILE__)), 'setmore_api')
Dir["#{path}/*.rb"].each { |f| require f }
Dir["#{path}/**/*.rb"].each { |f| require f }

module SetmoreApi
end