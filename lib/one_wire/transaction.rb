require 'socket'

module OneWire
  class Transaction
    attr_reader :response
    
    def initialize(type, path, options = {})
      host = options[:host] || OneWire::Config.host
      port = options[:port] || OneWire::Config.port
      socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      socket.connect(Socket.pack_sockaddr_in(port, host))
      OneWire::Request.new(socket, type, path, options)
      if type == :dir
        @response = []
        while true do
          response = OneWire::Response.new(socket)
          response.data ? @response << response : break
        end
      else
        @response = OneWire::Response.new(socket)
      end
    ensure
      socket.close if socket && !socket.closed?
    end
  
    class << self
      [ :dir, :dirall, :read, :presence ].each do |method|
        define_method method do |path, *args|
          new(method, path, *args)
        end
      end
      
      def write(path, value, options = {})
        new(:write, path, options.merge(:value => value))
      end
    end
  end
end