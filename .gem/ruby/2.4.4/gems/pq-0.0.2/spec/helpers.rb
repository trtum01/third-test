require 'pq'
require 'pry'
require 'tempfile'
require 'rspec'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'
end
