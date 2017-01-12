require_relative './errors/illegal_child_element_error'

module ObjectView 

  class Element 
    attr_accessor :tag, :attributes, :single_line
    attr_reader   :children, :acceptable_children
  
    def initialize
      @tab = "  "
      @single_line = false
      @tag = nil
      @attributes = Hash.new
      @children = []
      @acceptable_children = [String, Element]
    end
  
  
    def find_element_with_tag(tag)
      found = []
      @children.each do |child|
        if (child.is_a?(Element)) && (child.tag == tag)
          found << child
        end
      end
      if (found.length == 0)
        return nil
      elsif (found.length == 1)
        return found[0]
      else
        return found
      end
    end
  
    def attr(name, value)
      @attributes[name] = value
    end
  
    def acceptable_children=(value)
      @acceptable_children = value
    end
    
    def on_click=(value)
      self.attr("onclick", value)
    end
    
    def style=(the_style)
      self.attr("style", the_style)
    end

    def css_class=(value)
      self.attr("class", value)
    end

    def id=(value)
      self.attr("id", value)
    end

    def is_acceptable_child?(child)
      @acceptable_children.each do |good_class|
        if (child.is_a?(good_class)) 
          return true
        end
      end
      return false
    end
  
    def add(element_or_string)
      if (self.is_acceptable_child?(element_or_string))
        @children << element_or_string
      elsif (element_or_string.is_a?(Array))
        element_or_string.each do |child|
          add child
        end
      else
        raise IllegalChildElementError.new "Parent: #{self.tag} - Attempt to add an element that is not a valid child, and not an ObjectView::Element.  Class of element: #{element_or_string.class.name}:  #{element_or_string}\nTag of parent: #{self.tag}.\nAcceptable children: #{@acceptable_children.join(',')}"
      end
      return element_or_string
    end
    
    def add_with_tag(tag, content = nil)
      element = Element.new
      element.tag = tag
      if (content != nil)
        element.children << content
      end
      element.single_line = false
      self.children << element
      return element
    end
    
    def <<(item)
      self.add item
    end

    def render_children(indent = 0)
      html = StringIO.new
      @children.each do |child|
        if (indent != nil)
          if (!self.single_line)
            html << "\n"
          end
          html << @tab * indent
        end
        if (child.class.name == "String")
          html << child
        else
          child_html = child.render(indent)
          html << child_html
        end
      end
      return html.string
    end
  
    def render_attributes
      html = StringIO.new
      if (@attributes.length > 0)
        @attributes.each do |name, value|
          if (value.class == Hash)
            attr_value = ''
            value.keys.each do |key|
              attr_value += "#{key.to_s.gsub('_', '-')}: #{value[key]}"
              if (key != value.keys.last)
                attr_value += "; "
              end
            end
            html << " #{name}=\"#{attr_value}\""
          else
            html << " #{name}=\"#{value}\""
          end
        end
      end
      return html.string
    end
    
    def render(indent = 0)
      raise "tag not defined for class: #{self.class}" if (tag == nil) || (tag.strip.length == 0)
      html = StringIO.new
      if (indent != nil)
        html << (@tab * indent) 
      end
      html << "<#{tag}#{render_attributes}>"
      if (self.single_line)
        html << "#{render_children(nil)}" 
      else
        if (indent == nil)
          html <<  render_children(indent)
        else
          html <<  render_children(indent + 1)
        end
      end
    
    
      if (!self.single_line)
        html << "\n"
        if (indent != nil)
          html << @tab * indent 
        end
      end
      
      html << "</#{tag}>\n"
      return html.string
    end
  
  end
end