require 'grpc'
require 'device_services_pb'
require 'securerandom'

module Client
  def self.main(host, port)
    device_stub = Device::Device::Stub.new("#{host}:#{port}", :this_channel_is_insecure)

    request = Device::HeartbeatRequest.new(
      device_uid: SecureRandom.uuid,
      timestamp: Time.now.to_i)

    response = device_stub.heartbeat(request)
    puts "Heartbeat: #{response.to_hash}"
  end
end
