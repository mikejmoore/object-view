require_relative './element'

module ObjectView 

  class JavascriptFile < Element
  
    def initialize(file)
      super()
      self.single_line = true
      attr("type", "text/javascript")
      attr("src", file)
      @tag = "script"
      self.add " "
    end
  
  
  end
end