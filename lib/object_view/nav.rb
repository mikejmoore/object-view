module ObjectView 

  class Nav < Element 
    def initialize(content = nil)
      super()
      @tag = "nav"
      if (content != nil)
        self.add content
      end
    end
  end
end
