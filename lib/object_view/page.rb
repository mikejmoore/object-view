require_relative './element'
require_relative './body'
require_relative './head'
require_relative './header'
require_relative './javascript_file'
require_relative './div'
require_relative './span'
require_relative './javascript'
require_relative './table'
require_relative "./link"
require_relative "./chart_data"
require_relative "./chart_load_javascript"
require_relative "./chart_load_javascript_ajax"



module ObjectView 
  class Page < Element
    attr_accessor :head, :body, :title, :title_div, :top_div

    def initialize
      super
      self.tag = "html"
      @head = Head.new
      self.add @head
      @body = Body.new
      self.add @body
      @top_div = nil
      @title_div = nil
      @title = nil
      @acceptable_children = [Head, Body]
    end
    
    def displayed_title=(title)
      @top_div = self.body.add Div.new
      @title_div = self.body.add Div.new
      self.title_div.add(Header.new(1, title))
    end
    
    def title=(title)
      @title = title
      title_element = @head.find_element_with_tag("title")
      if (title_element == nil)
        title_element = @head.add_with_tag("title", title)
      end
      title_element.add(title)
    end
  
  end
end