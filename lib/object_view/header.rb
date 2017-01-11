require_relative './element'

module ObjectView 

  class Header < Element
    def initialize(n, text)
      super()
      @single_line = true
      @tag = "h#{n}"
      add text
    end
  
  end
end