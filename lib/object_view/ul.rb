require_relative './span'


module ObjectView 

  class Ul < Element 
  
    def initialize
      super()
      @tag = "ul"
      self.acceptable_children = [Li]
    end
    
    def item(content = nil)
      return self.add Li.new(content)
    end
  end
  
  
  class Li < Element
    def initialize(content = nil)
      super()
      @tag = "li"
      if (content != nil)
        self.add content
      end
    end
  end
end
