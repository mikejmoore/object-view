require_relative './span'


module ObjectView 

  class Div < Element 
  
    def initialize(content = nil)
      super()
      @tag = "div"
      if (content != nil)
        self.add content
      end
    end
  end
end
