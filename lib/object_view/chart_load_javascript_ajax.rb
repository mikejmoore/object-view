require_relative "./page"
require 'uri'


module ObjectView
  class ChartLoadJavascriptAjax < ObjectView::Javascript
  
    def initialize(chart_load_js_content, ajax_refresh_seconds = nil, prepend_script = "")
      super()
    
    
    
      script = "
      #{prepend_script}
    
      var _nextTimeToDraw = jQuery.now() + 1000;
      var _doingPeriodicCheck = false;
    
      function periodicCheck() {
        if (_initializedCharts) {
          if (!_doingPeriodicCheck) {
            _doingPeriodicCheck = true;
            var now = jQuery.now();
            if (_nextTimeToDraw != null) {
              if (now > _nextTimeToDraw) {
                _doingPeriodicCheck = false;
                if (_currentlyDrawing == false) {
                  _nextTimeToDraw = null;
                  drawChart();
                } else {
                }
              }
            }
            _doingPeriodicCheck = false;
          }
        } else {
          console.log('Waiting for google charts to initialize');
          initializeChart();
        }
      }
    
    
      var _chartRequestMade = false;
      function makeChartDrawRequest(time) {
        var nextTime = jQuery.now() + time;
        if ((_nextTimeToDraw == null) || (nextTime < _nextTimeToDraw)) {
          _nextTimeToDraw = nextTime;
        }
        console.log('Request to drawChart queued for: ' + _nextTimeToDraw);
      }
    
      function clearCharts() {
        #{clear_script_for_each_chart(chart_load_js_content)}
      }
    
    
        _currentlyDrawing = false;
        function drawChart() {
            console.log('drawChart called');
            try {
                _currentlyDrawing = true;
                console.log('Drawing charts.');
                //alert('drawChart()');
                 #{chart_data_load_script(chart_load_js_content)}
                 console.log('Finished drawing charts.');
        " 
      if (ajax_refresh_seconds != nil)   
        script += "     
                 console.log('finished drawing chart.  Queuing another drawChart request.');
      
                 makeChartDrawRequest(#{ajax_refresh_seconds * 1000});\n
                 _currentlyDrawing = false;
        "
      end
    
      script += "    
            }  catch(error) {
               console.log('Exception drawing chart: ' + error);
               _currentlyDrawing = false;
               makeChartDrawRequest(1000);
            }
            _currentlyDrawing = false;
          }
       "
    	chart_load_js_content.each do |chart_data|  
        script += " $('##{chart_data.id}').html('<h2 style=\"color: #aaaaaa\">Building Chart...</h2>'); \n"
      end
     
       script +=  "  initializeChart();\n;"
       script +=  "  setInterval(periodicCheck, 500);\n"
       if (ajax_refresh_seconds != nil)
         script += " makeChartDrawRequest(1000); \n"
       else
         script += "makeChartDrawRequest(1000);\n"
       end
       add script
    end    
  
  
    def clear_script_for_each_chart(chart_load_js_content) 
      script = ""
     	chart_load_js_content.each do |chart_data|  
        chart_data.id
        script += "  $('##{chart_data.id}').html('<h3 style=\"color: #aaaaaa\">Building Chart</h3>');\n"
      end
      return script
    end  
  
    
    def chart_data_load_script(chart_load_js_content)
      script = ""
     	chart_load_js_content.each do |chart_data|  
        params = []
        
        chart_data.ajax_params.each do |name, value|
        #  params_string += "#{name}=#{value}&"
          params << [name, value]
        end
        # if (params_string.length > 0)
        #   params_string = params_string[0..params_string.length - 2]
        # end
        params_string = URI.encode_www_form(params)
      
      
        chart_object = "Error"
        additional_options_script = ""
        if (chart_data.chart_type == :line)
          chart_object = "LineChart"
        elsif(chart_data.chart_type == :pie)
          chart_object = "PieChart"
        elsif(chart_data.chart_type == :stacked_area)
          chart_object = "AreaChart"
          additional_options_script = "   options['isStacked'] = true;\n"
        elsif(chart_data.chart_type == :area)
          chart_object = "AreaChart"
        elsif(chart_data.chart_type == :stepped_area)
          chart_object = "SteppedAreaChart"
        else
          raise ("chart_data needs a valid 'chart_type':  :line or :pie")
        end
      
        if (params_string.length > 0)
          script += "  var params = '#{params_string}';\n" 
          if (chart_data.ajax_method_for_params != nil)
            script += "  params = params + '&' + #{chart_data.ajax_method_for_params};\n" 
          end
        else
          if (chart_data.ajax_method_for_params != nil)
            script += "  var params = #{chart_data.ajax_method_for_params};\n" 
          else
            script += "  var params = '';\n" 
          end
        end
      
        script += "
          $.ajax({
            type: 'POST',
            url: '#{chart_data.ajax_url}',
            data: params,
            dataType: 'text',
            success: function(response) {
              //alert(\"Response: \" + response);
              var chartData = jQuery.parseJSON(response);

              //alert('Json: ' + chartData);
              var seriesJson = chartData.series;

              var options = chartData.options;
              #{additional_options_script}
              //alert('Options: ' + options);
            
               var series = [];
               for (var i = 0; i < seriesJson.length; i++) {
                 var dataPointJson = seriesJson[i];
                 var dataPoint = [];
                 dataPoint.push(dataPointJson[0].toString());
                 for (var j = 1; j < dataPointJson.length; j++) {
                   dataPoint.push(dataPointJson[j]);
                 }
                 series.push(dataPoint);
              }

              // var number = 5
              // var series = [ ['Time', 'Count'], [number.toString(), 0], ['04/30/2013', 0], ['05/28/2013', 0], ['06/25/2013', 0]  ];
              var chartElementId = '#{chart_data.id}';
              //alert('Series: ' + series);
              var chartData = google.visualization.arrayToDataTable(series);
              var chart = new google.visualization.#{chart_object}(document.getElementById(chartElementId));
            
               chart.draw(chartData, options);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
              $('##{chart_data.id}').html('<h3>Error getting chart data - QA server may be down.</h3>');
            }
          });
          "
       end
       return script    
    end  
  
  end
  
  
end