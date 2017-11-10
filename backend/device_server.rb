#!/usr/bin/env ruby

# gRPC server that implements the Device service.
#
# Usage: $ ./path/to/server.rb

require_relative 'config/boot'
require 'server'

Server::main
