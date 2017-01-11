require_relative "./page"

module ObjectView
  class ChartLoadJavascript < ObjectView::Javascript
  
    def initialize(chart_load_js_content)
      super()
      add "
      //  Chart Partial erb:  <%= Time.new.to_s%>

      function drawChart() {
          #{chart_data_load_script(chart_load_js_content)}
       }

      function initializeChart() {
    	  google.load('visualization', '1', {packages:['corechart']});
    	  google.setOnLoadCallback(drawChart);
      }
      initializeChart();
       "
    end    
    
    def chart_data_load_script(chart_load_js_content)
      script = ""
     	chart_load_js_content.each do |chart_data|  
        chart_object = "Error"
        if (chart_data.chart_type == :line)
          chart_object = "LineChart"
        elsif(chart_data.chart_type == :pie)
          chart_object = "PieChart"
        elsif(chart_data.chart_type == :stacked_area)
          chart_object = "AreaChart"
        elsif(chart_data.chart_type == :area)
          chart_object = "AreaChart"
        elsif(chart_data.chart_type == :stepped_area)
          chart_object = "SteppedAreaChart"
        else
          raise ("chart_data needs a valid 'chart_type':  :line or :pie")
        end
      
  #      Rails.logger.info "Chart data y-axis (as js render): #{chart_data.y_axis_labels}"
        y_axis_elements = ""
        chart_data.y_axis_labels.each do |label|
          y_axis_elements += "'#{label}'"
          if (chart_data.y_axis_labels.last != label)
            y_axis_elements += ", "
          end
        end

  #      script += "// #{chart_data.series}\n"
        script += "var chartArray = ([ \n" 
        script += "['#{chart_data.x_axis_label}', #{y_axis_elements}], \n"
        show_legend = false
     	  chart_data.series.each do |data|
       	  script += "         "
          script += "["
          if (data.length > 2)
            show_legend = true
          end

          (0..data.length - 1).each do |i|
            data_item = data[i]
            if (i == 0)
              script += "'#{data_item}'"
            else
              script += "#{data_item}"
            end
            if (i != data.length - 1)
              script += ", "
            end
          end
          script += "]"
          if (chart_data.series.last != data)
            script += ","
            script += "\n"
          end
     	  end    
     	  script += "    ]);\n"
     	  script += "      var chartData = google.visualization.arrayToDataTable(chartArray); \n" 
     	  script += "      var chart = new google.visualization.#{chart_object}(document.getElementById('#{chart_data.id}'));\n"
        if (chart_data.chart_type == :pie)
          script += "
           	  var options = {
           	 	  title: '#{chart_data.label}'
           	 }
             "
        else
          if (show_legend)
            legend_value = ""
          else
            legend_value = "legend: 'none',"
          end


          if(chart_data.chart_type == :stacked_area)
        
            script += "
             	  var options = {
                  vAxis: {minValue: 0},
                  isStacked: true,
             	 	  title: '#{chart_data.label}',
          		    displayAnnotations: true,
             		  curveType: 'function',
          		    fontSize: 10
             	 }
               "
           else        
              script += "
             	  var options = {
             	 	  title: '#{chart_data.label}',
                  #{legend_value}
          		    displayAnnotations: true,
             		  curveType: 'function',
          		    fontSize: 10
             	 }
               "
             end
         end
         script += "   chart.draw(chartData, options);\n"
       
       end
       return script    
    end  
  end
  
  
end