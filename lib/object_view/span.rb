module ObjectView 

  class Span < Element 
  
    def initialize(content = nil)
      super()
      @tag = "span"
      if (content != nil)
        self.add content
      end
    end
  end
end
