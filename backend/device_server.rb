#!/usr/bin/env ruby

# gRPC server that implements the Device service.
#
# Usage: $ ./path/to/server.rb

require_relative 'config/setup'
require 'server'

Server::main(5000)
