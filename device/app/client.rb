require 'concurrent'
require 'device_services_pb'
require 'grpc'
require 'securerandom'

module Client
  class Application
    def initialize(host, port, uid = Nil)
      @device_uid = uid || SecureRandom.uuid
      @device_stub = Backend::Device::Stub.new("#{host}:#{port}", :this_channel_is_insecure)
    end

    def heartbeat
      request = Backend::HeartbeatRequest.new(
        device_uid: @device_uid,
        timestamp: Time.now.to_i)
      response = @device_stub.heartbeat(request)
      puts "Heartbeat: #{response.to_hash}"
    rescue => e
      puts "Exception on heartbeat: #{e}"
    end

    def run
      task = Concurrent::TimerTask.new(execution_interval: 5) do
        heartbeat
      end
      task.execute
      task.wait_for_termination
    end
  end

  def self.main(device_uid)
    config = Config.instance.config['device']
    app = Application.new(config['host'], config['port'], device_uid)
    app.run
  end
end
