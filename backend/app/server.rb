require 'active_record'
require 'grpc'
require 'device_services_pb'

module Server
  # Implementation of the device RPC service.
  class DeviceService < Device::Device::Service
    def heartbeat(request, _call)
      puts "Heartbeat: #{request.to_hash}"
      Device::HeartbeatResponse.new
    end
  end

  # main starts an RpcServer that receives requests to DeviceServer.
  def self.main
    config = Config.instance.config
    puts config

    # Connect to database
    ActiveRecord::Base.establish_connection(config['database'])

    # Start server
    server = GRPC::RpcServer.new
    port = config['server']['port']
    server.add_http2_port("localhost:#{port}", :this_port_is_insecure)
    server.handle(DeviceService)
    puts "Starting RpcServer at localhost:#{port}"

    server.run
  end
end
