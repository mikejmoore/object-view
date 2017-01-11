require_relative './element'
module ObjectView 

  class Head < Element
    def initialize
      super
      @tag = "head"
    end
  
  end
end