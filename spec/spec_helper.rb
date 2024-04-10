require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
    config.formatter = :documentation
end

require 'pry'

require 'ship'
require 'cell'
require 'board'
require 'player'
require 'game'
require 'turn'



