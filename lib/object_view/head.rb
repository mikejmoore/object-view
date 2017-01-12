require_relative './element'
require_relative './javascript'
require_relative './javascript_file'
require_relative './link'

module ObjectView 

  class Head < Element
    
    def initialize
      super
      @tag = "head"
      self.acceptable_children = [Javascript, JavascriptFile, Link]
    end
  end
  
end