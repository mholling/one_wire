module OneWire
  class Device
    include Retry
  
    def initialize(address, options = {})
      @options = options
      @path = options[:uncached] ? "/uncached/#{address}" : "/#{address}"
      @path.squeeze!("/")
    end
    
    def present?
      Transaction.presence(@path, @options)
      true
    rescue Errno::ENOENT
      false
    end
    
    def read(attribute)
      with_retry { Transaction.read("#{@path}/#{attribute}").response.data || raise(BadRead) }
    end
    
    def write(attribute, value)
      with_retry { Transaction.write("#{@path}/#{attribute}", value) }
    end
    
    def dir
      Directory.new(@path)
    end
  end
end