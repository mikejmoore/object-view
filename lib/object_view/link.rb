module ObjectView 

  class Link < Element 
  
    def initialize(href = nil, label = nil)
      super()
      @tag = "a"
      
      if (href != nil)
        self.attr("href", href)
      end
      
      if (label != nil)
        self.add label
      end
    end
  end
end
