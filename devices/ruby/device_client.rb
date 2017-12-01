#!/usr/bin/env ruby

# Example device client that connects to the Device service.
#
# Usage: $ ./path/to/device.rb

require_relative 'config/setup'
require 'client'

device_uid = ARGV[0] if ARGV[0]
Client::main(device_uid)
