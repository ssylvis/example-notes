require 'active_record'
require 'grpc'
require 'device'
require 'device_services_pb'

module Server
  $log = Logger.new(STDOUT)

  class Application
    def initialize(config)
      $log.info(config)

      @port = config['server']['port']

      # Connect to database
      ActiveRecord::Base.establish_connection(config['database'])
    end

    def run
      # Start server
      server = GRPC::RpcServer.new
      server.add_http2_port("localhost:#{@port}", :this_port_is_insecure)
      server.handle(Server::DeviceService)
      $log.info("Starting RpcServer at localhost:#{@port}")

      server.run
    end
  end

  # Implementation of the device RPC service.
  class DeviceService < Backend::Device::Service
    def heartbeat(request, _call)
      $log.info("Heartbeat: #{request.to_hash}")

      # Update device heartbeat
      device = Model::Device.find_by_uid(request.device_uid)
      unless device
        device = Model::Device.new(device_uid: request.device_uid)
      end
      device.last_heartbeat = Time.at(request.timestamp).to_datetime
      device.save

      Backend::HeartbeatResponse.new
    rescue => e
      $log.error("Exception thrown", e)
      Backend::HeartbeatResponse.new
    end
  end

  # main starts an RpcServer that receives requests to DeviceServer.
  def self.main
    config = Config.instance.config
    app = Application.new(config)
    app.run
  end
end
