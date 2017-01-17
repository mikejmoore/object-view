require_relative './element'

module ObjectView 

  class Stylesheet < Element
    
    def initialize
      super
      @tag = "link"
      self.acceptable_children = []
    end
    
  end
  
end