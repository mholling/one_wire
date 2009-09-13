require 'singleton'

module OneWire
  Config = Struct.new(:host, :port, :units, :retry_interval, :dirall) do
    include Singleton
    
    def self.method_missing(*args)
      instance.send(*args)
    end
    
    self.host  = "localhost"
    self.port  = 4304
    self.units = :celsius
    self.retry_interval = 0.2
    self.dirall = true
  end
end
