require_relative 'middleware/runtime'
require_relative "app/router"
require_relative 'app'

use Runtime
run App.new
