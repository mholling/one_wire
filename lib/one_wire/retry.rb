module OneWire
  module Retry
    def with_retry
      errors_counts = Config.retries.map { |err, count| { Errno::const_get(err) => count } }.inject { |hash, h| hash.merge h }
      begin
        yield
      rescue *(errors_counts.map { |error, count| error if count > 0 }.compact) => e
        errors_counts[e.class] -= 1
        sleep Config.retry_interval
        retry
      end
    end
  end
end
