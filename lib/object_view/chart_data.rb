@@chart_id = 0


module ObjectView
  # ajax_method_for_params specifies a javascript method that will be called by ajax update script to retrieve non-static params
  # This method needs to be added to page and returns a string in the form :  "a=b&c=d&e=f"
  class ChartData
    attr_accessor :id, :series, :label, :chart_type, :x_axis_label, :y_axis_labels, :ajax_url, :ajax_params, :ajax_refresh_seconds, :ajax_method_for_params
  
    def initialize(type)
      @@chart_id += 1
      @ajax_method_for_params = nil
      @ajax_params = Hash.new
      @id = "chart_#{@@chart_id}"
      @chart_type = type
      @series = []
      @x_axis_label = "Time"
      @y_axis_labels = ["Count"]
    end
  
  end
end