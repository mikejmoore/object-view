require_relative './element'
require_relative './javascript'
require_relative './javascript_file'
require_relative './link'
require_relative './stylesheet'

module ObjectView 

  class Head < Element
    
    def initialize
      super
      @tag = "head"
      self.acceptable_children = [Javascript, JavascriptFile, Stylesheet, Title, String]
    end
    
    def add_stylesheet(path, id = Time.new.to_i.to_s)
      link = self.add Stylesheet.new
      link[:href] = path
      link[:id] = id
      link[:type] = 'text/css'
      link[:media] = 'screen'
      link[:rel] = 'stylesheet'
      return link
    end
    
    def add_title(title)
      self.add Title.new(title)
    end
    
  end
  
  class Title < Element
    
    def initialize(title)
      super()
      @tag = "title"
      self.acceptable_children = [String]
      self.add title if (title)
    end
  end
  
end