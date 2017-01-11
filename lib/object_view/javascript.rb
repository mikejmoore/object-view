require_relative './element'

module ObjectView 
  class Javascript < Element
  
    def initialize(content = nil)
      super()
      attr("type", "text/javascript")
      @tag = "script"
      if (content != nil)
        add content
      end
    end
  end
end