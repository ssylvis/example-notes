module Config
  def self.initialize
    # Load application directories
    base_dir = File.expand_path("..", __dir__)
    $LOAD_PATH << File.join(base_dir, 'app')
    $LOAD_PATH << File.join(base_dir, 'config')

    # Add shared proto definitions
    backend_dir = File.expand_path("../backend", base_dir)
    $LOAD_PATH << File.join(backend_dir, 'proto')
  end
end

Config::initialize
