require 'active_record'

module Model
  class Device < ActiveRecord::Base
    def self.find_by_uid(uid)
      where(device_uid: uid).first
    end
  end
end
