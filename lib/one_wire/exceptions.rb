module OneWire
  class ShortRead < RuntimeError
    def message
      "OWServer: short read"
    end
  end

  class BadRead < RuntimeError
    def message
      "OWServer: bad read"
    end
  end
end