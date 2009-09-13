module OneWire
  module Constants
    module Functions
      READ     = 2
      WRITE    = 3
      DIR      = 4
      PRESENCE  = 6
      DIRALL   = 7
    end
  
    module Units
      CELSIUS = 0x00000000
      FARENHEIT = 0x00010000
      KELVIN = 0x00020000
      RANKINE = 0x00030000
    end
  end
end