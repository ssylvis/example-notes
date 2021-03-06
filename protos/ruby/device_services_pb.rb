# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: device.proto for package 'backend'

require 'grpc'
require 'device_pb'

module Backend
  module Device
    # The device service definition.
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'backend.Device'

      # Sends a greeting
      rpc :Heartbeat, HeartbeatRequest, HeartbeatResponse
    end

    Stub = Service.rpc_stub_class
  end
end
