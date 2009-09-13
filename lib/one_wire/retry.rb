module OneWire
  module Retry
    def with_retry
      begin
        yield
      rescue Errno::EINVAL, ShortRead, BadRead => e
        # puts "#{e.inspect} ... retrying"
        sleep Config.retry_interval
        retry
      end
    end
  end
end