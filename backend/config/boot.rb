# Load application directories
base_dir = File.expand_path("..", __dir__)
$LOAD_PATH << File.join(base_dir, 'app')
$LOAD_PATH << File.join(base_dir, 'config')
$LOAD_PATH << File.join(base_dir, 'lib')
