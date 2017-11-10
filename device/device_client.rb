#!/usr/bin/env ruby

# Example device client that connects to the Device service.
#
# Usage: $ ./path/to/device.rb

require_relative 'config/setup'
require 'client'

Client::main("localhost", 5000)
