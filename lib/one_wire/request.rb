module OneWire
  class Request
    include OneWire::Constants::Functions
    def initialize(socket, type, path, options = {})
      version = 0
      payload = path + "\000"
      case type
      when :dir
        request_type, data_size = DIR, 0
      when :dirall
        request_type, data_size = DIRALL, 0
      when :read
        request_type, data_size = READ, 8192
      when :write
        request_type, data_size = WRITE, options[:value].size
        payload << options[:value] << "\000"
      when :presence
        request_type, data_size = PRESENCE, 0
      end
      flags = 0x05000000 | 0x00000002 | Constants::Units.const_get((options[:units] || Config.units).to_s.upcase)
      offset = 0
      header = [ version, payload.size, request_type, flags, data_size, offset ].pack("NNNNNN")

      socket.write(header + payload)
    end
  end
end