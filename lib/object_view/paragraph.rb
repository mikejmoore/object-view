module ObjectView 

  class Paragraph < Element 
  
    def initialize(content = nil)
      super()
      @tag = "p"
      if (content != nil)
        self.add content
      end
    end
    
  end
end
