require 'singleton'
require 'yaml'

class Config
  include Singleton

  attr_reader :config

  def initialize
    # Load application directories
    base_dir = File.expand_path("..", __dir__)
    $LOAD_PATH << File.join(base_dir, 'app')
    $LOAD_PATH << File.join(base_dir, 'config')

    # Add shared proto definitions
    backend_dir = File.expand_path("../../demo-backend/backend/", base_dir)
    $LOAD_PATH << File.join(backend_dir, 'protos')

    # Load application properties
    @config = YAML::load(File.open(File.join(__dir__, 'application.yml')))
  end
end

Config.instance
