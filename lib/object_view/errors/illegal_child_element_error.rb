require_relative './object_view_error'

module ObjectView
  class IllegalChildElementError < ObjectViewError
  
    def initialize(message = "Illegal child element")
      super(message)
    end
  
  end
end