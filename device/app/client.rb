require 'grpc'
require 'device_services_pb'
require 'securerandom'

module Client
  def self.main
    config = Config.instance.config['device']
    host = config['host']
    port = config['port']
    uid = config['uid']

    device_stub = Backend::Device::Stub.new("#{host}:#{port}", :this_channel_is_insecure)

    request = Backend::HeartbeatRequest.new(
      device_uid: uid,
      timestamp: Time.now.to_i)

    response = device_stub.heartbeat(request)
    puts "Heartbeat: #{response.to_hash}"
  end
end
