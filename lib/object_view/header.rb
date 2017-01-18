require_relative './element'

module ObjectView 

  class Header < Element
    def initialize(n = nil, text = nil)
      super()
      @single_line = true
      if (n)
        @tag = "h#{n}"
      else
        @tag = 'header'
      end
      if (text)
        add text
      end
    end
  
  end
end





