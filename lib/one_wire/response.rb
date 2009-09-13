module OneWire
  class Response
    def initialize(socket)
      header = socket.read(24)
      raise ShortRead unless header && header.size == 24
      version, payload_size, @return_value, @flags, data_size, offset = header.unpack('NNNNNN')
      raise SystemCallError, 2**32 - @return_value, "OWServer" if @return_value > 2**31
      raise BadRead if payload_size > 2**31 || data_size > 2**31
      # @data = socket.read(payload_size)[0...data_size] unless payload_size.zero?
      @data = payload_size.zero? ? "" : socket.read(payload_size)[0...data_size]
    end
    
    attr_reader :data, :return_value, :flags
  end
end