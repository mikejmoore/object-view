require_relative './element'

module ObjectView 

  class Image < Element
    def initialize(content = nil)
      super()
      @tag = "img"
      if (content)
        self.add content
      end
    end
  end
  
  def source=(value)
    self[:src] = value
  end
  
  def source
    return self[:src]
  end
end
