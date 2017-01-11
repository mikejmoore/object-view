require_relative './element'
module ObjectView 

  class Body < Element
    def initialize
      puts "Creating body"
      super
      @tag = "body"
    end
  
  end
end