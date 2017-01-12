require_relative './element'
module ObjectView 

  class Body < Element
    def initialize
      super
      @tag = "body"
    end
  
  end
end