#!/usr/bin/env ruby

# gRPC server that implements the Device service.
#
# Usage: $ path/to/greeter_server.rb

require_relative 'config/boot'
require 'application'

Application::main
