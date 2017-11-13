require 'active_record'
require 'device'
require 'device_services_pb'
require 'grpc'

module Server
  # Implementation of the device RPC service.
  class DeviceService < Backend::Device::Service
    def heartbeat(request, _call)
      puts "Heartbeat: #{request.to_hash}"

      # Update device heartbeat
      device = Model::Device.find_by_uid(request.device_uid)
      unless device
        device = Model::Device.new(device_uid: request.device_uid)
      end
      device.last_heartbeat = Time.at(request.timestamp).to_datetime
      device.save

      Backend::HeartbeatResponse.new
    rescue => e
      puts "Exception thrown: #{e}"
      Backend::HeartbeatResponse.new
    end
  end

  # main starts an RpcServer that receives requests to DeviceServer.
  def self.main
    config = Config.instance.config

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
