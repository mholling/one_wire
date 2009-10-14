module OneWire
  class Response
    def initialize(socket)
      begin
        header = socket.read(24)
        raise ShortRead unless header && header.size == 24
        version, payload_size, @return_value, @flags, data_size, offset = header.unpack('NNNNNN')
        raise SystemCallError, 2**32 - @return_value, "OWServer" if @return_value > 2**31
      end while payload_size > 2**31 # negative payload size indicates a server 'keep-alive' ping
      raise BadRead if data_size > 2**31
      @data = socket.read(payload_size)[0...data_size] unless payload_size.zero?
    end
    
    attr_reader :data, :return_value, :flags
  end
end